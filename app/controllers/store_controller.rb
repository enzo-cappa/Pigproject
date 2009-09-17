class StoreController < ApplicationController
  before_filter :find_cart, :except => :empty_cart

  def index
    @letter = params[:letter].blank? ? 'a' : params[:letter]
    @letter_options_list = Product.find_products_for_sale.collect!{ |c| c.title[0,1].upcase }.uniq
    if params[:letter] == '#'
      @products = Product.find_products_for_sale(["title REGEXP ?", "^[^a-z]"])
    else
      @products = Product.find_products_for_sale(["title LIKE ?","#{params[:letter]}%"])
    end
#    @products = Product.find_products_for_sale
    @cart = find_cart
  end


  def add_to_cart
    product = Product.find(params[:id])
    @cart = find_cart
    @current_item = @cart.add_product(product)
    respond_to do |format|
      format.js if request.xhr?
      format.html {redirect_to_index}
    end
  rescue ActiveRecord::RecordNotFound
    logger.error("Attempt to access invalid product #{params[:id]}" )
    redirect_to_index("Invalid product")
  end

  def empty_cart
    session[:cart] = nil
    redirect_to_index
  end

  def checkout
    @cart = find_cart
    if @cart.items.empty?
      redirect_to_index("Your cart is empty" )
    else
      @order = Order.new
    end
  end

  def save_order
    @cart = find_cart
    @order = Order.new(params[:order])
    @order.add_line_items_from_cart(@cart)
    if @order.save
      session[:cart] = nil
      redirect_to_index(I18n.t('flash.thanks' ))
    else
      render :action => 'checkout'
    end
  end

  protected

  def authorize
  end

  private

  def find_cart
    @cart = (session[:cart] ||= Cart.new)
  end

  def redirect_to_index(msg = nil)
    flash[:notice] = msg if msg
    redirect_to :action => 'index'
  end

end
