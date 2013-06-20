class ExtminController < ApplicationController
	before_filter :require_admin

	def index
		@users = User.all
	end

	def show 
		@user = User.find(params[:id])
	end

	private
	def require_admin
		unless user_signed_in? && current_user.admin?
			flash[:notice] = "You aint no admin"
			redirect_to root_path
		end

	end


end
