class ShowsController < ApplicationController
  before_action :set_show, only: [:show, :edit, :update, :destroy, :follow, :unfollow]

  def index
    @active="shows"
    @title = "Shows"
    # @shows = Show.all
    @shows=Show.where(:approved => true, :single => false).order(:created_at).includes(:episodes)
  end

  # GET /shows/1
  # GET /shows/1.json
  def show
     @active="shows"
  
     # @f = @show.user_followers.random(5)
     # @followers = (@f.compact!).nil? ? @f : @f.compact!

     @followers = @show.user_followers.offset(rand(@show.user_followers.count)).limit(5)
    
    if(@episode.nil?) 
       @episode = @show.episodes.first
    end

    @title = @show.title + ' : ' + @episode.title
    if(!@episode.tag_list.empty?)
        @page_keywords = 'blog,' +  @episode.tag_list.to_s
    end
    
    @likers = @episode.votes.up.by_type(User).voters.compact
    # @voters = Votes.where(votable: @episode).random(3).map(&:voter)
  end



  def follow
      current_user.follow(@show)
      respond_to do |format|
        format.js {render :action=>"follow"}
      end
  end

  def unfollow
    current_user.stop_following(@show)
    respond_to do |format|
      format.js {render :action=>"unfollow"}
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_show
    # @show = Show.find(params[:id])
     # @show = Show.friendly.find(params[:id])
     @show = Show.includes(:episodes).where("episodes.approved" => true).friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def show_params
    params.require(:show).permit(:title, :description, :approved)
  end






end
