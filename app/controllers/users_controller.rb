class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :follow, :unfollow]

	def new
		@birthday = Date.civil(params[:user]["birthday(1i)"].to_i,
                        params[:report]["birthday(2i)"].to_i,
                        params[:report]["birthday(3i)"].to_i)
	end

	def index
		@users = User.all
		@groups = @users.each_slice(4).to_a
	end


	def show
	end



def follow
	puts ''
	puts '  #########  follow  #########'
	puts ''
	current_user.follow(@user)
	respond_to do |format|
		format.js {render :action=>"follow"}
	end
end

def unfollow
	puts ''
	puts '  #########  UN follow  #########'
	puts ''
# @sh = Show.find(params[:id])
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