class PostsController < ApplicationController
	before_action :set_post, only: [:show]


	def index
		@active = "posts"
		@posts = Post.published
	end

	def show
		@active = "posts"
		@posts = Post.published
		@latest = Post.latest(5)
	end

	private
	def set_post
		@post = Post.friendly.find(params[:id])
	end
end
