class PagesController < ApplicationController
  
  def home
    @title = "Home"
    @features = Feature.all
    @shows = Show.all
    @episodes = Episode.all
  end

  def contact
    @title = "Contact Us"
  end
  
  def about
    @title = "About Us"
  end
  
  def shows
    @title = "Shows"
  end
  
end
