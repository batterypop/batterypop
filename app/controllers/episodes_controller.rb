class EpisodesController < ApplicationController
  before_action :set_episode, only: [:show, :edit, :update, :destroy]

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
def popUnPop
  # @picture = Picture.find(params[:id])
  # @episode.liked_by current_user
  # redirect_to @episode
  if(!current_user.nil?)
    if(current_user.voted_for? @episode)
      @episode.liked_by current_user
    else
      @episode.disliked_by current_user
  end
end



  # POST /episodes
  # POST /episodes.json
  # def create
  #   @episode = Episode.new(episode_params)

  #   respond_to do |format|
  #     if @episode.save
  #       format.html { redirect_to @episode, notice: 'Episode was successfully created.' }
  #       format.json { render action: 'show', status: :created, location: @episode }
  #     else
  #       format.html { render action: 'new' }
  #       format.json { render json: @episode.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PATCH/PUT /episodes/1
  # # PATCH/PUT /episodes/1.json
  # def update
  #   respond_to do |format|
  #     if @episode.update(episode_params)
  #       format.html { redirect_to @episode, notice: 'Episode was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: 'edit' }
  #       format.json { render json: @episode.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /episodes/1
  # # DELETE /episodes/1.json
  # def destroy
  #   @episode.destroy
  #   respond_to do |format|
  #     format.html { redirect_to episodes_url }
  #     format.json { head :no_content }
  #   end
  # end

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
