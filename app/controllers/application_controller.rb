class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def validate_jwt
  	hmacsecret = 'cobabelajar123'
  	token = request.headers['Authorization']

  	begin
  		dec = JWT.decode token, hmacsecret, true, { :algorithm => 'HS256' }
  	rescue
  		response = {
  			status: '403',
  			message: 'not allowed'
  		}

  		render :json => response.to_json
  	end	
  end

  def ensure_admin
  	hmacsecret = 'cobabelajar123'
  	token = request.headers['Authorization']

  	begin
  		user = JWT.decode token, hmacsecret, true, { :algorithm => 'HS256' }

  		if user[0]["role"] == "admin"
  		else	
  			response = {
	  			status: '403',
	  			message: 'only admin allowed'
	  		}

	  		render :json => response.to_json
  		end	
  	rescue
  		response = {
  			status: '403',
  			message: 'token not valid'
  		}

  		render :json => response.to_json
  	end
  end	
end
