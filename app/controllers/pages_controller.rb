class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update]
  
  def home
    @banner_ad = "/31902320/Homepage_Leaderboard"
    @banner_id = 'div-gpt-ad-1411455733171-0'
    # @banner_id = 'div-gpt-ad-1413353062754-0'
  

    @title = "Free Videos for Kids"
    @active = "home"

    @shorts = Show.where(:single => true, :approved => true).includes(:episodes)

    @features = Feature.homepage.active
    @showlist = Show.showlist.approved.shuffle
    # @popped = Episode.mostpopped(10) 
    @popped = Episode.mostpopped_by_month(10)

    @promoted = Show.where(:promote => true).order('updated_at DESC')

    @channels = Channel.get_channels_approved
    
    # if !cookies[:viewedWelcome].present?
    #   @cookie = false
    #   cookies[:viewedWelcome] = { :value => "true", :expires => 1.day.from_now}
    # else
    #   @cookie = true
    # end
  end

  def search
    @query = params[:query]
    @title = "Search Return: " + @query
    # @return = PgSearch.multisearch(@query).where(:searchable_type => "User")
    @users = User.listable.search_text(@query);
    @creators = Creator.search_text(@query)
    # @vids = PgSearch.multisearch(@query).where.not(:searchable_type => "Post", :searchable_type => "User", :searchable_type => "Creator")
    @vids = PgSearch.multisearch(@query).where(:searchable_type => "Episode")
    @posts = PgSearch.multisearch(@query).where(:searchable_type => "Post")
  end

  def bot
  end


  def investors
    @title = "Investors"
  end

  def contact
    @title = "Contact Us"
    @active = "contact"
  end
  
  # def about
  #   @title = "About Us"
  #   @active = "about"
  # end
  
  def shows
    @title = "Shows"
    @active = "shows"
  end

  def shorts
    @title = "Shorts"
     @active = "shorts"
    @shorts = Show.where(:single => true, :approved => true).includes(:episodes)
    # @groups = @shorts.each_slice(4).to_a
  end

  # def creators
  #   @title = "Calling All Creators"
  #    @active = "creators"
  # end

  # def privacy
  #   @title = "Privacy Policy"
  #    @active = "privacy"
  # end

  # def terms
  #   @title = "Terms and Conditions"
  #   @active = "terms"
  # end

  # def advertise
  #   @title = "Advertise on batteryPOP!"
  #    @active = "advertise"
  # end


  def show
    @active = @page.slug
    @title = @page.title
  end


  private 
  def check_cookie
    
  end

  def set_page
    @page = Page.friendly.find(params[:id])
  end



end