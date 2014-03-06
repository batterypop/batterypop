class ChannelsController < ApplicationController
	  before_action :set_channel, only: [:feed, :show, :edit, :update, :destroy]

  def index
     @active="channels"
     @title = "Channels"
    # @channels = Channel.all.order('position ASC')
    @channels = Channel.get_channels
  end

  
  def show
     @active="channels"
     @title = "Channel: " + @channel.title
   

    respond_to do |format|
      format.rss {render :layout => false }
      # format.roku {render :layout => false }
      format.roku {render :layout => false }
      format.json { render :json => @channel }
      format.html {
        if @channel.hidden? 
          redirect_to "/"
        end
      }
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
