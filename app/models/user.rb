class User < ApplicationRecord
  has_many      :posts, dependent: :destroy
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
    Post.where("user_id = ?", id)
  end
  
  
  private
  
  def downcase_email
    email.downcase!
  end
  

end
