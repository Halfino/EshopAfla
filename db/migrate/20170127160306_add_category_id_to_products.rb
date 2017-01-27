class AddCategoryIdToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :category, index: true, foregin_key: true
    add_foreign_key :products, :categories
  end
end
