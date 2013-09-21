class CreatorsController<ApplicationController
	before_action :set_creator, only: [:show]

	def index
		@creators = Creator.all
	end

	def show
	end

	private
	def set_creator
		@creator = Creator.friendly.find(params[:id])
	end
	def creator_params
		params.require(:creator).permit(:displayname, :username)
	end
end