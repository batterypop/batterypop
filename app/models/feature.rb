class Feature < ActiveRecord::Base


	def feature_params
		params.require(:feature).permit(:title, :content)
	end

	scope :active, -> {where(:active => true).order(:position)}

end
