class PagesController < ApplicationController
  
  def home
    @title = "Home"
    @features = Feature.active
    @showlist = Show.showlist.approved.shuffle
    @popped = Episode.mostpopped(10) 
    @promoted = Show.where(:promote => true)
    if !cookies[:viewedWelcome].present?
      @cookie = false
      cookies[:viewedWelcome] = { :value => "true", :expires => 1.day.from_now}
    else
      @cookie = true
    end
  end

  def contact
    @title = "Contact Us"
     @active = "contact"
  end
  
  def about
    @title = "About Us"
     @active = "about"
  end
  
  def shows
    @title = "Shows"
     @active = "shows"
  end

  def shorts
    @title = "Shorts"
     @active = "shorts"
    @shorts = Show.where(:single => true, :approved => true).includes(:episodes)
    puts " "
    puts "  %%%%%%%%%%% "
    @shorts.inspect

    puts ""
    puts ""
    # @groups = @shorts.each_slice(4).to_a
  end

  def creators
    @title = "Calling All Creators"
     @active = "creators"
  end

  def privacy
    @title = "Privacy Policy"
     @active = "privacy"
  end

  def terms
    @title = "Terms and Conditions"
    @active = "terms"
  end

  def advertise
    @title = "Advertise on batteryPOP!"
     @active = "advertise"
  end



  private 
  def check_cookie
    
  end

  # def getGACode
  #   case Rails.env
  #     when 'production'
  #       @gacode = "UA-44486746-1"
  #     when 'staging'
  #       @gacode = "UA-44486746-2"
  #   end
  # end

end