class AddIndexToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_index :subscriptions, [:user_id, :category_id], unique: true
  end
end
