class MediaController < ApplicationController

   def index
   	puts " (******************"
   		ap Time.new
puts "  #  #********"

      redirect_to "http://grimmwerks.com/video/slp_walkthrough_backend.mp4"
   end  
   
end