class AddForeignKeyPostCategory < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :posts, :categories, index: true
  end
end
