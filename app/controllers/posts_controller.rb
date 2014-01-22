class PostsController < ApplicationController
	before_action :set_post, only: [:show]


	def index
		@title = "bLOG"
     	@active = "blog"
		@posts = Post.published
	end

	def show
		@title = "bLOG: " + @post.title
		@active = "posts"
		@posts = Post.published
		@latest = Post.published.latest(5)
		if(!@post.tag_list.empty?)
	        @page_keywords = @post.tag_list.to_s
	    end
	end

	private
	def set_post
		@post = Post.friendly.find(params[:id])
	end
end
