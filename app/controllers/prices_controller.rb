class PricesController < ApplicationController

  # GET /prices/new
  # GET /prices/new.xml
  def new
    @price = Price.new
    @price.product = Product.find(params[:product])
    
    render 'prices/new'
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @price }
#    end
  end

  # POST /prices
  # POST /prices.xml
  def create
    @price = create_price
    if @price.save
      price_created
    else
      respond_to do |format|
        format.html { render '/prices/new' }
      end
    end
  end

  protected

  def create_price
    raise NotImplementedError
  end

  def get_all_prices
    raise NotImplementedError
  end

  def price_created 
    raise NotImplementedError
  end 
  
end
