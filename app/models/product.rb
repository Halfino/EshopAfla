class Product < ActiveRecord::Base
  belongs_to :category
  has_many :cart_products

  before_destroy :ensure_not_referenced_by_item_in_cart

  private
    def ensure_not_referenced_by_item_in_cart
      if cart_products.empty?
        return true
      else
        errors.add(:base, 'Produkty v kosiku')
        return false
      end
    end
end
