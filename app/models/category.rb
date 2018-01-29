class Category < ApplicationRecord
  has_many    :posts, dependent: :destroy
  has_many    :subscribers, class_name: "Subscription", dependent: :destroy
  belongs_to  :user
  validates :name,  presence: true, uniqueness: { case_sensitive: false}
  
  def posts
    Post.where("category_id = ?", id)
  end
end
