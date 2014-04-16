class Devise::Custom::CreatorSanitizer  < Devise::ParameterSanitizer

	def sign_up
		default_params.permit(:username, :email, :displayname, :password, :password_confirmation)
	end


end