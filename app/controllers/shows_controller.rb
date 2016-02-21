  class ShowsController < ApplicationController
  before_action :set_show, only: [:show, :edit, :update, :destroy, :follow, :unfollow]
 
  before_action :set_index, only: [:index]

  def index
    @active="shows"
    @title = "Shows"

    @banner_ad = "/31902320/Shows_main_leaderboard"
    @banner_id = 'div-gpt-ad-1411894179579-0'

    @description = "The best web series around! Catch the shows everyone is talking about right here, and share your favorites with your friends."
  end

  # GET /shows/1
  # GET /shows/1.json
  def show
    @banner_ad = "/31902320/Shows_Leaderboard"
    @banner_id = 'div-gpt-ad-1411894829676-0'
     @dfp_header = "shows"
     @active="shows"
     @show_follow_status = ''
     # @f = @show.user_followers.random(5)
     # @followers = (@f.compact!).nil? ? @f : @f.compact!

     @followers = @show.user_followers.offset(rand(@show.user_followers.count)).limit(5)
     
    if(@episode.nil?) 
       @episode = @show.episodes.first
    end


    @ga_page_params = ", {'dimension1':  '#{@episode.creator.id}', 'dimension2': '#{@episode.id}'}"

    #we want to have different items based on single or episodic info
    @description = @show.single? ? @show.description : @episode.description
    @title = @show.single? ? @show.title : "#{@show.title} : #{@episode.title}"

   

#meta fun

    # @meta_description = @show.single? ? "#{@show.title} : #{@episode.description}" : "#{@show.title} : #{@episode.title} - #{@episode.description}"
    @meta_description = "#{@title} - #{@episode.description}"
    if(!@episode.tag_list.empty?)
        @page_keywords = @episode.tag_list.to_s
    end
    if(!@episode.keyword_list.empty?)
        @page_keywords = @episode.keyword_list.to_s
    end
    # if current user following
   if !current_user.nil? && current_user.following?(@show)
       @show_follow_status = "You are following"
   else
       @show_follow_status = "status"
   end
    
    @likers = @episode.votes.up.by_type(User).voters.compact
    # @voters = Votes.where(votable: @episode).random(3).map(&:voter)
  end



  def follow
    unless current_user.nil?
      current_user.follow(@show)
      @show_follow_status = "You are following"
      current_user.touch  # cache clear; TODO: sweeper?
      # respond_to do |format|
      #   format.js {render :action=>"follow"}
      # end
    end
  end

  def unfollow
    unless current_user.nil?
      current_user.stop_following(@show)
       @show_follow_status = ""
       current_user.touch  # cache clear; TODO: sweeper?
    end
    # respond_to do |format|
    #   format.js {render :action=>"unfollow"}
    # end
  end

  def edit
    redirect_to "/"
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_show
    # @show = Show.find(params[:id])
     # @show = Show.friendly.find(params[:id])
     #@show = Show.includes(:episodes).where("episodes.approved" => true).friendly.find(params[:id])
     @show = Show.includes(:episodes).where("episodes.approved" => true).order('episodes.episode').friendly.find(params[:id])
  end

  # look up list of shows based upon alpha
  def set_index
    # binding.pry
    @alpha = params[:alpha]
    if @alpha.nil? 
      @alpha = "A"
    end
    if @alpha == 'num'
      srch = ["title LIKE ? or title LIKE ? or title LIKE ? or title LIKE ? or title LIKE ? or title LIKE ? or title LIKE ? or title LIKE ? or title LIKE ? or title LIKE ? or title LIKE ? or title LIKE ? or title LIKE ? or title LIKE ? or title LIKE ? or title LIKE ? or title LIKE ? or title LIKE ? or title LIKE ? or title LIKE ?"]
      (0..9).each do |i|
        srch  << "#{i}%"
        srch  <<  "The #{i}%"
      end
     
      # binding.pry
      # there should be regex mysql to look up the numerical first rather than this lame setup, but for now
       
    else
        srch = ["title LIKE ? or title LIKE ?", "#{@alpha}%", "The #{@alpha}%"]
    end
    @shows=Show.series.order(:title).includes(:episodes).where(srch)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def show_params
    params.require(:show).permit(:title, :description, :approved)
  end


#           con = ActiveRecord::Base.connection()

  #           sql = "select v.link_id, l.linkedmedia_id as episode_id,  e.title as episode,  count(*) as count from visits as v, links as l, episodes as e  where v.created_at::TEXT like '#{thisday}%' and (v.link_id = l.id) and (e.id = l.linkedmedia_id)  group by e.title, v.link_id, l.id order by count desc limit 10;"

  #           result = con.execute(sql)





end
