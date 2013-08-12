class Devise::Custom::ParamaterSanitizer  < Devise::ParameterSanitizer

	def sign_up
		default_params.permit(:username, :email, :firstname, :lastname, :password, :birthday, :gender)
	end


end