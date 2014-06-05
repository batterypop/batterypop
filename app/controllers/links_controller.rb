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

		@visitor = Visitor.new(:session_id =>  @_request.session.id , :http_user_agent => @_request.env['HTTP_USER_AGENT'], :remote_addr =>  @_request.env['REMOTE_ADDR'] ,  :http_accept_language => @_request.env['HTTP_ACCEPT_LANGUAGE'] )
		if !current_user.nil?
			@visitor.user = current_user
		end
		@visitor.link = @link
		
		redirect_to @link.url
	end

	private
	def set_link
		@link = Link.find(params[:id])
	end
end