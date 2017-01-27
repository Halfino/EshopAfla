class Cart < ActiveRecord::Base
  has_many :cart_products, dependent: :destroy

  def add_product(product_id)
    current_product = cart_products.find_by(product_id: product_id)
    if current_product
      current_product.quantity += 1
    else
      current_product = cart_products.build(product_id: product_id)
    end
    current_product
  end
end
