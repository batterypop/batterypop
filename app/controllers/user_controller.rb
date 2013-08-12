class UserController < ApplicationController

	def new
		@birthday = Date.civil(params[:user]["birthday(1i)"].to_i,
                         params[:report]["birthday(2i)"].to_i,
                         params[:report]["birthday(3i)"].to_i)

		
	end

	
end
