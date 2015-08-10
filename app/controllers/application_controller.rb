class ApplicationController < ActionController::Base
	before_filter :authenticate_user!
	before_filter :set_current_user

	protect_from_forgery
	rescue_from CanCan::AccessDenied do |exception|
		redirect_to root_url, :alert => exception.message
	end

	def set_current_user
		if current_user
			Thread.current[:user_id] = current_user.id
		end
	end
end
