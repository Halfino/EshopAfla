class CreateCartProducts < ActiveRecord::Migration
  def change
    create_table :cart_products do |t|
      t.references :product
      t.belongs_to :cart, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
