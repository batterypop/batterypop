class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :follow, :unfollow, :hint]

	def new
		@birthday = Date.civil(params[:user]["birthday(1i)"].to_i,
                        params[:report]["birthday(2i)"].to_i,
                        params[:report]["birthday(3i)"].to_i)
	end

	def index
		@users = User.all
	end


	def show
	end


	def hint
		 # @user = User.friendly.find(params[:username])
		 @question = SecurityQuestion.find(@user.security_question_id).name
	end

	def password
		if @user
			userAnswer = @user.security_question_answer.gsub(/[^0-9a-z]/i, '').downcase
			paramAnswer = params[:answer].gsub(/[^0-9a-z]/i, '').downcase
			if userAnswer == paramAnswer
		        render json: { password: @user.encrypted_password }
		      else
		        render json: { password: nil }
		      end
	    else
	      render json: { password: nil }
	    end
	end


def follow
	current_user.follow(@user)
	respond_to do |format|
		format.js {render :action=>"follow"}
	end
end

def unfollow
	current_user.stop_following(@user)
	respond_to do |format|
		format.js {render :action=>"unfollow"}
	end
end


	private
	def set_user
		@user = User.friendly.find(params[:id])
	end
	
end