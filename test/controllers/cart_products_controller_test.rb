require 'test_helper'

class CartProductsControllerTest < ActionController::TestCase
  setup do
    @cart_product = cart_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cart_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cart_product" do
    assert_difference('CartProduct.count') do
      post :create, cart_product: { cart_id: @cart_product.cart_id, product: @cart_product.product }
    end

    assert_redirected_to cart_product_path(assigns(:cart_product))
  end

  test "should show cart_product" do
    get :show, id: @cart_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cart_product
    assert_response :success
  end

  test "should update cart_product" do
    patch :update, id: @cart_product, cart_product: { cart_id: @cart_product.cart_id, product: @cart_product.product }
    assert_redirected_to cart_product_path(assigns(:cart_product))
  end

  test "should destroy cart_product" do
    assert_difference('CartProduct.count', -1) do
      delete :destroy, id: @cart_product
    end

    assert_redirected_to cart_products_path
  end
end
