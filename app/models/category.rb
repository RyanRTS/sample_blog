class Category < ApplicationRecord
  has_many  :posts, dependent: :destroy
  belongs_to :user
  validates :name,  presence: true, uniqueness: { case_sensitive: false}
  
  def posts
    Post.where("category_id = ?", id)
  end
end
