# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  require "will_paginate"

  before_filter :fetch_logged_in_user
   
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  private #----------------

  def authorize_access
    if not session[:user_id]
      flash[:notice] = "Please log in."
      redirect_to(:controller => 'admins', :action => 'login')
      return false
    end  
  end
  
  
  protected #----------------
    def fetch_logged_in_user
    	return unless session[:user_id]
		@current_user = User.find_by_id(session[:user_id])
 end

end
