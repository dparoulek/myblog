# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  layout 'blueprint'

  require 'guarddog/authentication'
  include GuardDog::Authentication

  require 'bloodhound/bloodhound'
  include BloodHound

  before_filter :auth_required
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
