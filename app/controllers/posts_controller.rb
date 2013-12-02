class PostsController < ApplicationController
	before_action :set_post, only: [:show]


	def index
		@active = "posts"
		@posts = Post.all
	end
	
	def show
		@active = "posts"
	end

	private
	def set_post
		@post = Post.friendly.find(params[:id])
	end
end
