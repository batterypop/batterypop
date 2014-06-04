class LinksController < ApplicationController
	before_action :set_link

	def show
		
		puts "   **************"
		ap params
		puts " ***************"
	end


	def file
		# puts @link.episode.title		
		# ga_track_event("Users", "Login", "Standard")
		@episode = @link.linkedmedia
		@show = @episode.show
		ga_track_event("Test", "begin", "#{@show.title} : #{@episode.title}")
		redirect_to @link.url
	end

	private
	def set_link
		@link = Link.find(params[:id])
	end
end