class AdministratorsController < ApplicationController
  # GET /administrators
  # GET /administrators.xml
  def index
    @admins = Administrator.find(:all, :order => :name)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admins }
    end
  end

  # GET /administrators/1
  # GET /administrators/1.xml
  def show
    @admins = Administrator.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @admins }
    end
  end

  # GET /administrators/new
  # GET /administrators/new.xml
  def new
    @admin = Administrator.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin }
    end
  end

  # GET /administrators/1/edit
  def edit
    @admin = Administrator.find(params[:id])
  end

  # POST /administrators
  # POST /administrators.xml
  def create
    @admin = Administrator.new(params[:administrator])

    respond_to do |format|
      if @admin.save
        flash[:notice] = "User #{@admin.name} was successfully created."
        format.html { redirect_to(:action=>'index' ) }
        format.xml  { render :xml => @admin, :status => :created, :location => @admin }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /administrators/1
  # PUT /administrators/1.xml
  def update
    @admin = Administrator.find(params[:id])
    respond_to do |format|
      if @admin.update_attributes(params[:user])
        flash[:notice] = "User #{@admin.name} was successfully updated."
        format.html { redirect_to(:action=>'index' ) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @admin = User.find(params[:id])
    begin
      flash[:notice] = "User #{@admin.name} deleted"
      @admin.destroy
    rescue Exception => e
      flash[:notice] = e.message
    end
    respond_to do |format|
      format.html { redirect_to(administrators_url) }
      format.xml { head :ok }
    end

  end
end
