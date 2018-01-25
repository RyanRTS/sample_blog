class AddDefaultToPostCategory < ActiveRecord::Migration[5.1]
  def change
    change_column_default :posts, :category_id, 0
  end
end
