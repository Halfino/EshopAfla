class PagesController < ApplicationController
  def index
    @products = Product.all
  end

  def ovoce
    select_products_by_category(select_category_by_id("Ovoce"))
  end

  def zelenina
    select_products_by_category(select_category_by_id("Zelenina"))
  end

  def napoje
    select_products_by_category(select_category_by_id("Napoje"))
  end

  private
  def select_products_by_category(category)
    @products = Product.where(category_id: category)
  end

  def select_category_by_id(name)
    @catId = Category.where(name: name)
  end
end

