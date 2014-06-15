class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :current_admin

	rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
	
	private

	def current_user
	  @current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def current_admin
		@current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]		
	end

	def current_ability
		@current_ability ||= case 
												when current_user
													Ability.new(current_user)
												when current_admin
													AdminAbility.new(current_admin)
		end
	end
end
