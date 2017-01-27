class Cart < ActiveRecord::Base
  has_many :cart_products, dependent: :destroy

  def add_product(product_id, pocet)
    current_product = cart_products.find_by(product_id: product_id)
    if current_product
      current_product.quantity = current_product.quantity + pocet.to_i
    else
      current_product = cart_products.build(product_id: product_id, quantity: pocet.to_i)
    end
    current_product
  end
end
