class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :follow, :unfollow]

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


	# def follow
	# 	@user = find(params[:id])
	# 	if current_user
	# 		if current_user == @user
	# 	      flash[:error] = "You cannot follow yourself."
	# 	    else
	# 	      current_user.follow(@user)
	# 	      RecommenderMailer.new_follower(@user).deliver if @user.notify_new_follower
	# 	      flash[:notice] = "You are now following #{@user.monniker}."
	# 	    end
	# 	else
	# 		 flash[:error] = "You must <a href='/users/sign_in'>login</a> to follow #{@user.monniker}.".html_safe
	# 	end
	# end

	# def unfollow
	#   @user = User.find(params[:id])
	#   if current_user
	#     current_user.stop_following(@user)
	#     flash[:notice] = "You are no longer following #{@user.monniker}."
	#   else
	#     flash[:error] = "You must <a href='/users/sign_in'>login</a> to unfollow #{@user.monniker}.".html_safe
	#   end
	# end



	private
	def set_user
		@user = User.friendly.find(params[:id])
	end
	
end