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



def follow
	current_user.follow(@show)
	respond_to do |format|
		format.js {render :action=>"follow"}
	end
end

def unfollow
# @sh = Show.find(params[:id])
	current_user.stop_following(@show)
	respond_to do |format|
		format.js {render :action=>"unfollow"}
	end
end


	private
	def set_user
		@user = User.friendly.find(params[:id])
	end
	
end