class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :number
      t.string :package
      t.integer :minimum_order
      t.decimal :price
      t.decimal :customer_price
      t.string :image_url

      t.timestamps null: false
    end
  end
end
