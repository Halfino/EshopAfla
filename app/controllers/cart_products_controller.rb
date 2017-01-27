class CartProductsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]
  before_action :set_cart_product, only: [:show, :edit, :update, :destroy]

  # GET /cart_products
  # GET /cart_products.json
  def index
    @cart_products = CartProduct.all
  end

  # GET /cart_products/1
  # GET /cart_products/1.json
  def show
  end

  # GET /cart_products/new
  def new
    @cart_product = CartProduct.new
  end

  # GET /cart_products/1/edit
  def edit
  end

  # POST /cart_products
  # POST /cart_products.json
  def create
    product = Product.find(params[:product_id])
    @cart_product = @cart.cart_products.build(product: product)

    respond_to do |format|
      if @cart_product.save
        format.html { redirect_to carts_path, notice: 'Zbozi bylo vlozeno do kosiku' }
        format.json { render :show, status: :created, location: @cart_product }
      else
        format.html { render :new }
        format.json { render json: @cart_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cart_products/1
  # PATCH/PUT /cart_products/1.json
  def update
    respond_to do |format|
      if @cart_product.update(cart_product_params)
        format.html { redirect_to pages_index_path, notice: 'Cart product was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart_product }
      else
        format.html { render :edit }
        format.json { render json: @cart_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_products/1
  # DELETE /cart_products/1.json
  def destroy
    @cart_product.destroy
    respond_to do |format|
      format.html { redirect_to cart_products_url, notice: 'Cart product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_product
      @cart_product = CartProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_product_params
      params.require(:cart_product).permit(:product, :cart_id)
    end
end
