class PostsController < ApplicationController
	before_action :set_post, only: [:show]


	def index
		@title = "bLOG"
     	@active = "blog"
     	@banner_ad = "/31902320/Blog_leaderboard"
   		@banner_id = 'div-gpt-ad-1413352958218-0'
	   	@dfp_header = "posts"
		# @posts = Post.published
		@posts = Post.published.paginate(:page => params[:page], :per_page => 5)
		@latest = Post.published.latest(5)
		@feed_title = "batteryPOP bLOG"
		@blog_description = "From hot topics to the coolest trends, the batteryPOP blog has a few words for everyone!"
		@description = "#{@feed_title}: #{@blog_description}"
		@updated = @posts.first.updated_at unless @posts.empty?
		respond_to do |format|
			format.html
			format.atom {@posts = Post.published.all; render :layout => false}
			format.rss {@posts = Post.published.all; render :layout => false }
		end
	end

	def show
    	@dfp_header = "posts"
     	@banner_ad = "/31902320/Blog_leaderboard"
   		@banner_id = 'div-gpt-ad-1413352958218-0'
		@title = "bLOG: " + @post.title
		@active = "posts"
		@description = "#{@post.body}"
		# @posts = Post.published
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
