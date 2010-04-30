class AdminController < ApplicationController
  def login
    if request.post?
      user = Administrator.authenticate(params[:name], params[:password])
      if !user
        user = User.authenticate(params[:name], params[:password])
        if user
          session[:user_id] = user.id
          fortune = `fortune \| recode LATIN1..UTF8` 
          flash[:notice] = fortune
          redirect_to(:controller => :store, :action => "index" )
        else
          flash.now[:notice] = "Invalid user/password combination"
        end
      else
        session[:admin_id] = user.id
        redirect_to(:action => "index" )
      end
    end
  end

  def logout
    session[:user_id] = nil
    session[:admin_id] = nil
    flash[:notice] = "Logged out"
    redirect_to(:controller => :store , :action => "index")
  end

  def index
    @total_orders = Order.count
  end
end
