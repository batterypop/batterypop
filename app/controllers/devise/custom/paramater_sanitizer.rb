class Devise::Custom::ParamaterSanitizer  < Devise::ParameterSanitizer

	def sign_up
		default_params.permit(:username, :email, :firstname, :lastname, :password, :birthday, :gender, :password_confirmation, :avatar_id, :security_question_id, :security_question_answer)
	end


end