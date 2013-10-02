class PagesController < ApplicationController
  
  def home
    @title = "Home"
    @features = Feature.all
    @shows = Show.all
    @episodes = Episode.all
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
    @shorts = Show.where(:single => true, :approved => true)
    @groups = @shorts.each_slice(6).to_a
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

end