class User < ApplicationRecord
  has_many      :posts,         dependent: :destroy
  has_many      :categories,    dependent: :destroy
  has_many      :subscriptions, dependent: :destroy
  before_save   :downcase_email
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates     :email, presence: true, length: { maximum: 255 },
                  format: { with: VALID_EMAIL_REGEX },
                  uniqueness: { case_sensitive: false}
  validates     :name,  presence: true, length: { maximum: 50 }
  validates     :password, presence: true, length: {minimum: 6}, allow_nil: true
                  
  has_secure_password
  
   # Returns the has digest of given string
  def User.digest(string)
   cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost 
   BCrypt::Password.create(string, cost: cost)
  end
  
  # Returns a random token
  def User.new_token
   SecureRandom.urlsafe_base64 
  end
  
  # Remembers a user in the database for us in persistent sessions
  def remember
   self.remember_token = User.new_token
   update_attribute(:remember_digest, User.digest(remember_token)) 
  end
  
  # Returns true if the given token matches the digest
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  def activate
    update_columns(activated: true,  activated_at: Time.zone.now)
  end
  
  def feed
    subscribed_category_ids = "SELECT category_id FROM subscriptions
                               WHERE user_id = :user_id"
    Post.where("user_id = :user_id OR category_id IN (#{subscribed_category_ids})", user_id: id)
  end
  
  def subscribe(category)
    subscription = subscriptions.create(category: category)
    subscriptions << subscription
  end
  
  def unsubscribe(subscription)
    subscriptions.delete(subscription)
  end
  
  def subscribed?(category)
    subscriptions.include?(Subscription.where("category_id = ? AND user_id = ?", category.id, id).first)
  end
  
  
  private
  
  def downcase_email
    email.downcase!
  end
  

end
