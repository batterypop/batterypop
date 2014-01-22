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
     # @episode = Episode.friendly.find(params[:id])
     @show = @episode.show
      @followers = @show.user_followers.offset(rand(@show.user_followers.count)).limit(5)
      @likers = @episode.votes.up.by_type(User).voters.compact
      # show / episode title unless short
      if(e.show.single?)
         @title = @episode.show.title
      else
        @title = @episode.show.title + ' : ' + @episode.title
      end
      if(!@episode.tag_list.empty?)
        @page_keywords = @episode.tag_list.to_s
      end
     render 'shows/show'
  end

  # GET /episodes/new
  def new
    @episode = Episode.new
  end

  # GET /episodes/1/edit
  def edit
  end

# voting
  def pop
    unless current_user.nil?
       @episode.liked_by current_user
    end


  end

  def unpop
    unless current_user.nil?
       @episode.unliked_by current_user
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
