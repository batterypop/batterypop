class ShowsController < ApplicationController
  before_action :set_show, only: [:show, :edit, :update, :destroy, :follow, :unfollow]

  def index
    @active="shows"
    # @shows = Show.all
    @shows=Show.where(:approved => true, :single => false)
  end

  # GET /shows/1
  # GET /shows/1.json
  def show
     @active="shows"
     @f = @show.user_followers.random(5)
     @followers = (@f.compact!).nil? ? @f : @f.compact!
    
    if(@episode.nil?) 
       @episode = @show.episodes.first
    end
    
    @likers = @episode.votes.up.by_type(User).voters.compact!
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



  # def follow
  #   if current_user
  #     current_user.follow(@show)
  #     # RecommenderMailer.new_follower(@user).deliver if @user.notify_new_follower
  #     flash[:notice] = "You are now following #{@show.title}."
   
  #   else
  #      flash[:error] = "You must <a href='/users/sign_in'>login</a> to follow #{@show.title}.".html_safe
  #   end
  # end

  # def unfollow
  #   if current_user
  #     current_user.stop_following(@show)
  #     flash[:notice] = "You are no longer following #{@show.title}."
  #   else
  #     flash[:error] = "You must <a href='/users/sign_in'>login</a> to unfollow #{@show.title}.".html_safe
  #   end
  # end


  # def create
  #   @user = User.find(params[:user_id])
  #   current_user.follow(@user)
  # end
 
  # def destroy
  #   @user = User.find(params[:user_id])
  #   current_user.stop_following(@user)
  # end




   ## Scopes for calculating relative users
  # scope :created_yesterday, lambda { where(:created_at.gte => (Time.now - 1.day)) }
  # scope :created_last_week, lambda { where(:created_at.gte => (Time.now - 1.week)) }

  # GET /shows/new
  # def new
  #   @show = Show.new
  # end

  # GET /shows/1/edit
  # def edit
  # end

  # POST /shows
  # POST /shows.json
  # def create
  #   @show = Show.new(show_params)

  #   respond_to do |format|
  #     if @show.save
  #       format.html { redirect_to @show, notice: 'Show was successfully created.' }
  #       format.json { render action: 'show', status: :created, location: @show }
  #     else
  #       format.html { render action: 'new' }
  #       format.json { render json: @show.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /shows/1
  # PATCH/PUT /shows/1.json
  # def update
  #   respond_to do |format|
  #     if @show.update(show_params)
  #       format.html { redirect_to @show, notice: 'Show was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: 'edit' }
  #       format.json { render json: @show.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /shows/1
  # DELETE /shows/1.json
  # def destroy
  #   @show.destroy
  #   respond_to do |format|
  #     format.html { redirect_to shows_url }
  #     format.json { head :no_content }
  #   end
  # end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_show
      # @show = Show.find(params[:id])
       @show = Show.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def show_params
      params.require(:show).permit(:title, :description, :approved)
    end
end
