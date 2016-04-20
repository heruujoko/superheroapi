class UserController < ApplicationController

	protect_from_forgery with: :null_session
	before_action :ensure_admin, only: [:index]
	# before_action :ensure_admin, only: [:index]
	
	def store
		user = User.create({
			username: params[:username],
			email: params[:email],
			password: params[:password],
			role: params[:role]
		})

		render :json => user.to_json

	end	

	def index
		users = User.all

		render :json => users.to_json
	end	

end
