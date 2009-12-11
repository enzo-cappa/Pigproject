class StoreController < ApplicationController
  before_filter :find_cart, :except => :empty_cart

  def index
    @letter = params[:letter].blank? ? 'a' : params[:letter]
    @letter_options_list = Product.for_sale.collect!{ |c| c.title[0,1].upcase }.uniq
    @products = Product.for_sale.starting_with(params[:letter])
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

#  def checkout
#    @cart = find_cart
#    if @cart.items.empty?
#      redirect_to_index("Your cart is empty" )
#    else
#      @order = Order.new
#    end
#  end

  def save_order
    user = User.find_by_id(session[:user_id])
    if user
      @cart = find_cart
      @order = Order.new()
      @order.user = user
      @order.add_line_items_from_cart(@cart)
      if @order.save
        session[:cart] = nil
        redirect_to_index(I18n.t('flash.thanks' ))
      else
        redirect_to_index("Error sending order. Probably there isn't enough stock")
      end
    else
      flash[:notice] = "Please log in"
      redirect_to :controller => 'admin' , :action => 'login'
    end
  end

  def amount_for_user
    user = User.find_by_id(session[:user_id])
    if user
      @amount = user.actual_account_state
    else
      flash[:notice] = "Please log in"
      redirect_to :controller => 'admin' , :action => 'login'
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
