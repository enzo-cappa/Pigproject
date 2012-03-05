# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  layout "store"
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :authenticate_user!#, :except => [ :login, :logout ]
  before_filter :set_locale

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def default_url_options(options={}) 
    {:locale => I18n.locale} 
  end

  protected

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
