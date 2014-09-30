class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :follow, :unfollow, :save_avatar]
	rescue_from ActiveRecord::RecordNotFound, with: :user_not_found
	# around_filter :catch_not_found

	def new
		@birthday = Date.civil(params[:user]["birthday(1i)"].to_i,
                        params[:report]["birthday(2i)"].to_i,
                        params[:report]["birthday(3i)"].to_i)
	end

	def index
		# using username_avatar_age_gender to see if user shoudl be listed
		@users = User.listable 
	end


	def show
		if(current_user != @user && !@user.publish_public_profile)
			redirect_to "/"
		end
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



def save_avatar
	@avatar = Avatar.find(params['user']['avatar_id'])
	@user.avatar = @avatar
	@user.save
	puts @user.avatar_id
	redirect_to :action => "show"
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

	def user_not_found
		flash[:notice] = "User not found."
		redirect_to "/users", :flash => { :error => "User not found." }
    end
	
end