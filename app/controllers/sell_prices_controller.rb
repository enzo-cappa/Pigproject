class SellPricesController < PricesController

  protected
  
  def create_price
    SellPrice.new(params[:price])
  end

  def get_all_prices
    SellPrice.find_all_by_product_id(params[:product])
  end

  def price_created
    prices = @price.product.sell_prices
    responds_to_parent do 
      render :update do |page|
        page.replace_html 'sell_prices', :partial => 'products/sell_prices', :object => prices
        page.call 'Windows.closeAll'
      end
    end      
  end
  
end
