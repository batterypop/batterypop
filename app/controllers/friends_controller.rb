class FriendsController < ApplicationController
	before_action :set_friend, only: [:show, :edit, :update, :destroy]


	def index
		redirect_to "/"
		# @title = "Friends"
		# @active = "friends"
		# @friends = Friend.all

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

	

	private
	def set_friend
		# @friend = Friend.includes(:episodes).includes(:features).where("features.active" => true).friendly.find(params[:id])
		@friend = Friend.includes(:episodes).includes(:features).friendly.find(params[:id])
	end
end