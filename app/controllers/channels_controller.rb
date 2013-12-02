class ChannelsController < ApplicationController
	  before_action :set_channel, only: [:feed, :show, :edit, :update, :destroy]

  def index
     @active="channels"
    # @channels = Channel.all.order('position ASC')
    @channels = Channel.get_channels
  end

  
  def show
     @active="channels"
     @viddler = Viddler::Client.new('1ftfdc24uw7rv3pxqv51')
     @viddler.authenticate! 'batterypop@gmail.com', 'purple2013'

    respond_to do |format|
      format.html
      format.rss {render :layout => false }
    end

    
  end



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
