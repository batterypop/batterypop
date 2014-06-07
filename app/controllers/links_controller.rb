class LinksController < ApplicationController
	before_action :set_link

	def show
		if(@link.link_type="file")
			file
		end
	end


	def file
		# puts @link.episode.title		
		# ga_track_event("Users", "Login", "Standard")
		@episode = @link.linkedmedia
		@show = @episode.show

		ga_track_event("Video", "begin", "#{@show.title} : #{@episode.title}")

		@visit = Visit.new(:session_id =>  @_request.session.id , :http_user_agent => @_request.env['HTTP_USER_AGENT'], :remote_addr =>  @_request.env['REMOTE_ADDR'], :request_uri => @_request.env['REQUEST_URI'],  
			:http_accept_language => @_request.env['HTTP_ACCEPT_LANGUAGE'] )

		if !current_user.nil?
			@visit.user = current_user
		end
		@visit.link = @link
		@visit.save

		redirect_to @link.url
	end


	private
	def set_link
		@link = Link.find(params[:id])
	end
end