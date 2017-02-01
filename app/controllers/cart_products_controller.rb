class CartProductsController < ApplicationController
  include CurrentCart
  #before_action :set_cart, only: [:create]
  before_action :set_cart_final, only: [:create]
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
  # add product to cart and assign cart to user if user logegd in. If there is cart already belongs to user
  # this cart is used instead of creating a new one
  def create
    product = Product.find(params[:product_id])
    quantity = params[:pocet]
    @cart_product = @cart.add_product(product.id, quantity)
    :add_cart_to_current_user
    respond_to do |format|
      if @cart_product.save
        if user_signed_in?
          user = current_user
          user.cart_id = @cart.id
          user.save
        end
        format.html { redirect_to @cart, notice: 'Zbozi bylo vlozeno do kosiku' }
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
      params.require(:cart_product).permit(:product, :pocet)
    end

    # add cart_id to users table if user logged in
    def add_cart_to_current_user(cart_id)
      if user_signed_in
        user = current_user
        user.cart_id = cart_id
        user.save
      end
    end

    # set cart method.
    # if there is signed in user and cart in DB which belongs to that user, this cart is selected for adding product
    # to cart. In the other ways new cart is created.
    def set_cart_final
      if user_signed_in?
        user = current_user
        if user.cart_id != nil
          # logged user get cart which is in db belongs to this user.
          begin
            @cart = Cart.find(user.cart_id)
            session[:cart_id] = user.cart_id
          # if the cart desn't exists, new cart is created
          rescue ActiveRecord::RecordNotFound
            begin
              @cart = Cart.find(session[:cart_id])
            rescue ActiveRecord::RecordNotFound
              @cart = Cart.create
              session[:cart_id] = @cart.id
            end
          end
        end
      else
        # if user signed out, find session cart, rescuing to create new if session cart isnt find
        begin
          @cart = Cart.find(session[:cart_id])
        rescue ActiveRecord::RecordNotFound
          @cart = Cart.create
          session[:cart_id] = @cart.id
        end
      end
    end
end
