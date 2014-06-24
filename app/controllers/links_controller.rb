class LinksController < ApplicationController
	before_action :set_link

	def show
		# if(@link.link_type="file")
		# 	file
		# end
	end


	def file
		# puts @link.episode.title		
		# ga_track_event("Users", "Login", "Standard")
		@episode = @link.linkedmedia
		@show = @episode.show
		finished('home_display_test')
		save_visit(home_display_test)
		redirect_to @link.url
	end


	def feed
		@episode = @link.linkedmedia
		@show = @episode.show
		save_visit(params[:channel])
		redirect_to @link.url
	end


	def save_visit(data=nil)
		@tmp = {:session_id => @_request.session.id, :link_id => @link.id, :time => Time.now}

		

		
		if (session[:last_saved_visit].nil?  || 
			 (session[:last_saved_visit][:session_id] != @tmp[:session_id]) ||
			  (session[:last_saved_visit][:link_id] != @link.id) ||
			  ((session[:last_saved_visit][:session_id] == @tmp[:session_id]) && (session[:last_saved_visit][:link_id] == @link.id) && (@tmp[:time] > 15.minutes.since(session[:last_saved_visit][:time])))
			)

			@visit = Visit.create(:session_id =>  @_request.session.id , :http_user_agent => @_request.env['HTTP_USER_AGENT'], :remote_addr =>  @_request.env['REMOTE_ADDR'], :request_uri => @_request.env['REQUEST_URI'],  :data => data,
			:http_accept_language => @_request.env['HTTP_ACCEPT_LANGUAGE'], :user => current_user, :link => @link )

			session[:last_saved_visit] = @tmp
			ga_track_event("Video", "begin", "#{@show.title} : #{@episode.title}")

			# finished('home_display_test', :reset => false)
			

		end

	end

	private
	def set_link
		@link = Link.find(params[:id])
	end
end