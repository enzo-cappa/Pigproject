class DepositsController < ApplicationController
  # GET /deposits
  # GET /deposits.xml
  def index
    @deposits = Deposit.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @deposits }
    end
  end


  # GET /deposits/new
  # GET /deposits/new.xml
  def new
    @deposit = Deposit.new
    users = User.find(:all, :order => 'name')
    @users = users.map {|u| [u.name, u.id] }
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @deposit }
    end
  end

  # POST /deposits
  # POST /deposits.xml
  def create
    @deposit = Deposit.new(params[:deposit])
    respond_to do |format|
      if @deposit.save
        flash[:notice] = 'Deposit was successfully created.'
        format.html { redirect_to :action => 'index' }
      else
        users = User.find(:all, :order => 'name')
        @users = users.map {|u| [u.name, u.id] }
        format.html { render :action => "new" }
        format.xml  { render :xml => @deposit.errors, :status => :unprocessable_entity }
      end
    end
  end

  def amount_by_user

    @users_amount_map = { }

    User.find(:all).each do |u|
      deposits = u.deposits.sum(:amount)
      orders = 0
      u.orders.each do |o|
        o.line_items.each do |l|
          orders += l.quantity * l.product.price
        end
      end
      total = deposits - orders
      @users_amount_map [u.name] = total
    end


  end

end
