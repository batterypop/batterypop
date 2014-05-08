class CreatorsController<ApplicationController
	before_action :set_creator, only: [:show]

	respond_to :html, :xml, :json

	def index
		@creators = Creator.all
	end

	def show
		if !@creator.hidden?
			@title = "Creator: #{@creator.displayname}"
			@description = "Creator: #{@creator.displayname} #{@creator.bio}"
			@ga_page_params = ", {'dimension1':  '#{@creator.id}'}"

		else
			redirect_to "/"
		end
	end

	def dashboard
		# @title ="DASHBOARD"
		# ap current_creator
		
		if current_creator.nil? 
			redirect_to "/creators/sign_in"
		else
			@creator = current_creator
			@title = "Dashboard: #{current_creator.displayname}"
			# g=e.votes.up.by_type(User).voters.group_by &:gender
			# e.show.followers.group_by(&:gender)
		end
	end



	def draw_chart_bar
		@element =  params['element']
	end

	def draw_chart_donut
		@element =  params['element']
	end


	private
	def set_creator
		@creator = Creator.includes(:shows).friendly.find(params[:id])
	end
	def creator_params
		params.require(:creator).permit(:displayname, :username)
	end


	

end