class ChannelsController < ApplicationController
	  before_action :set_channel, only: [:show, :edit, :update, :destroy]

  def index
    @channels = Channel.all
  end

  
  def show
  end

  # def new
  #   @channel = Channel.new
  # end

  # def edit
  # end


  # def create
  #   @channel = Channel.new(channel_params)

  #   respond_to do |format|
  #     if @channel.save
  #       format.html { redirect_to @channel, notice: 'Channel was successfully created.' }
  #       format.json { render action: 'show', status: :created, location: @show }
  #     else
  #       format.html { render action: 'new' }
  #       format.json { render json: @channel.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PATCH/PUT /shows/1
  # # PATCH/PUT /shows/1.json
  # def update
  #   respond_to do |format|
  #     if @channel.update(channel_params)
  #       format.html { redirect_to @channel, notice: 'Channel was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: 'edit' }
  #       format.json { render json: @channel.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /shows/1
  # # DELETE /shows/1.json
  # def destroy
  #   @show.destroy
  #   respond_to do |format|
  #     format.html { redirect_to shows_url }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel
      @channel = Channel.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def channel_params
      params.require(:show).permit(:title, :description, :slug)
    end
end
