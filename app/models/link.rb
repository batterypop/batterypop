class Link < ActiveRecord::Base
	belongs_to :linkedmedia, :polymorphic =>  true

	def link_params
		params.require(:link).permit(:url, :type, :views)
	end

end