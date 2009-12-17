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

  def top_buyers
    @users = User.find(:all)
    @users = @users.sort_by{|u| -u.buyed_amount }
  end

  protected

  def authorize
  end

end

