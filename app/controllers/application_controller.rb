# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  layout "store"
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :authorize, :except => [ :login, :logout ]
  before_filter :set_locale

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  protected

  def authorize_as_user
    unless User.find_by_id(session[:user_id])
      flash[:notice] = "Please log in"
      redirect_to :controller => 'admin' , :action => 'login'
    end
  end

  def authorize
    unless Administrator.find_by_id(session[:admin_id])
      flash[:notice] = "Please log in"
      redirect_to :controller => 'admin' , :action => 'login'
    end
  end

  def set_locale
    session[:locale] = params[:locale] if params[:locale]
    I18n.locale = session[:locale] || I18n.default_locale
    locale_path = "#{LOCALES_DIRECTORY}#{I18n.locale}.yml"
    unless I18n.load_path.include? locale_path
      I18n.load_path << locale_path
      I18n.backend.send(:init_translations)
    end
  rescue Exception => err
    logger.error err
    flash.now[:notice] = "#{I18n.locale} translation not available"
    I18n.load_path -= [locale_path]
    I18n.locale = session[:locale] = I18n.default_locale
  end


end
