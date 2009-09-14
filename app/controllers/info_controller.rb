class InfoController < ApplicationController

  def who_bought
    @product = Product.find(params[:id])
    @orders = @product.orders
    respond_to do |format|
      format.html
      format.json { render :layout => false ,
        :json => @product.to_json(:include => :orders) }

    end
  end

  protected

  def authorize
  end
  
end

