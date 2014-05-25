class EpisodesController < ApplicationController
  before_action :set_episode, only: [:show, :edit, :update, :destroy, :pop, :unpop ]


  # GET /episodes
  # GET /episodes.json
  def index
    @episodes = Episode.all
  end

  # GET /episodes/1
  # GET /episodes/1.json
  def show
    @show = @episode.show
    @followers = @show.user_followers.offset(rand(@show.user_followers.count)).limit(5)
    @likers = @episode.votes.up.by_type(User).voters.compact

    if(!@episode.tag_list.empty?)
      @page_keywords = @episode.tag_list.to_s
    end
     @description = @episode.description


     # @ga_custom = "ga('set', 'dimension1', '#{@episode.creator.id}');"
     @ga_page_params = ", {'dimension1':  '#{@episode.creator.id}', 'dimension2': '#{@episode.id}'}"

     
    # need to know if this is a friend or show render
    if params.has_key?(:show_id)
       @title = @episode.slide_title
       render 'shows/show'
    elsif params.has_key?(:friend_id)
      @friend = Friend.friendly.find(params["friend_id"])
      @title = @friend.title
      render 'friends/show'
    end
  end

  # GET /episodes/new
  def new
    @episode = Episode.new
  end

  # GET /episodes/1/edit
  def edit
    redirect_to "/"
  end


# voting
  def pop
    # unless current_user.nil?
    #    @episode.liked_by current_user
    # end
    if current_user.nil?
      @episode.chicago = Integer(@episode.chicago.to_i) + 1
      @episode.save
    else
       @episode.liked_by current_user
       current_user.touch
     end
     expire_fragment("shows_most_popped")
  end

  def unpop
    unless current_user.nil?
       @episode.unliked_by current_user
      current_user.touch
       expire_fragment("shows_most_popped")
     end
  end


  def refresh
    @episode = Episode.find(params[:id]);
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_episode
      @episode = Episode.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def episode_params
      params.require(:episode).permit(:title, :description, :approved, :creator_id, :show_id, :video_type, :video_id)
    end
end
