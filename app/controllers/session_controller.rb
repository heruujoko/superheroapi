class SessionController < ApplicationController

	protect_from_forgery with: :null_session

	def auth
		hmacsecret = 'cobabelajar123'

		user = User.where("email = ?",params[:email]).first
		if user && user.authenticate(params[:password])
			token = JWT.encode user,hmacsecret,'HS256'

			response = {
				status: 200,
				message: 'Authentication success',
				data: {
					token: token
				}
			}
			
			render :json => response.to_json			
		else
			response = {
				status: 404,
				message: 'User not found'
			}

			render :json => response.to_json
		end	
	end	

end
