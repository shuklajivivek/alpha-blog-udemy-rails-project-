class ApplicationController < ActionController::Base
    
    helper_method :current_user, :logged_in? #this makes this method also a helper method
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
        # ||= is used for memoization of @current_user variable
      end
  #NOTE: Helper methods are accessible to views only but not controllers
  #hence by moving the methods from helper to here will be accessible to both
  #any methods define in this controller will be accessible to all controllers
  #since all controllers inherit this controller

  def logged_in?
    !!current_user #here !! converts @current_user into boolean
  end
end
