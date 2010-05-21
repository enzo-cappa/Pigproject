class AbstractUsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    @users = get_class.find(:all)

    respond_to do |format|
      format.html {render 'abstract_users/index' }# index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = get_class.find(params[:id])

    respond_to do |format|
      format.html {render 'abstract_users/show' }# show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = get_class.new

    respond_to do |format|
      format.html { render 'abstract_users/new' }# new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = get_class.find(params[:id])
    @categories = [:administrator, :user]
    render 'abstract_users/edit'
  end

  # POST /users
  # POST /users.xml
  def create
    @user = get_class.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = "User #{@user.name} was successfully created."
        format.html { redirect_to(:action=>'index' ) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render 'abstract_users/new' }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = get_class.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = "User #{@user.name} was successfully updated."
        format.html { redirect_to(:action=>'index' ) }
        format.xml  { head :ok }
      else
        format.html { render 'abstract_users/edit' }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = get_class.find(params[:id])
    begin
      flash[:notice] = "User #{@user.name} deleted"
      @user.destroy
    rescue Exception => e
      flash[:notice] = e.message
    end
    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml { head :ok }
    end

  end

  protected

  def  get_class
    raise NotImplementedError
  end

end
