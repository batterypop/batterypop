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

  def shorts
    @title = "Shorts"
    @shorts = Show.where(:single => true, :approved => true)
    @groups = @shorts.each_slice(6).to_a
  end

end