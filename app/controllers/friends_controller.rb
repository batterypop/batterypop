class FriendsController < ApplicationController
	before_action :set_friend, only: [:show, :edit, :update, :destroy, :follow, :unfollow]


	def index
		# redirect_to "/"
		@title = "Friends"
		@active = "friends"
		@friends=Friend.series.order(:created_at).includes(:episodes).paginate(:page => params[:page], :per_page => 8)
	    @description = "Check out these cool videos from batteryPOP's coolest friends!."
	end

	def show
		if @friend.approved
			@title = @friend.title
			if @friend.background.present? 
				@custom_background = @friend.background(:original)
			end
			if(@episode.nil?) 
				@episode = @friend.episodes.first
				@show = @episode.show
			end
		else
			redirect_to "/"
		end
	end

	def follow
		unless current_user.nil?
		  current_user.follow(@friend)
		  @friend_follow_status = "You are following"
		  current_user.touch  # cache clear; TODO: sweeper?
		end
	end

	def unfollow
		unless current_user.nil?
		  current_user.stop_following(@friend)
		   @friend_follow_status = ""
		   current_user.touch  # cache clear; TODO: sweeper?
		end
	end

	

	private
	def set_friend
		# @friend = Friend.includes(:episodes).includes(:features).where("features.active" => true).friendly.find(params[:id])
		@friend = Friend.includes(:episodes).includes(:features).friendly.find(params[:id])
	end
end