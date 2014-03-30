class CategoriesController < ApplicationController
	before_action :set_category, only: [:show]

	def index
		@categories = Category.all
	end
	
	def show
		@title = "bLOG Category: #{@category.title}"
		@active = "blog"
		@description = "batteryPOP bLOG in the #{@category.title} category listing."
		@latest = Post.published.latest(5)
		@posts = @category.posts.published.paginate(:page => params[:page], :per_page => 5)
	end

	private
	def set_category
		@category = Category.friendly.find(params[:id])
	end
end
