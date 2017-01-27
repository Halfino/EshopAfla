class AddCartIdToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :cart, index: true, foreign_key: true
    add_foreign_key :users, :carts
  end
end
