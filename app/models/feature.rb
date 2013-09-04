class Feature < ActiveRecord::Base

	def feature_params
		params.require(:feature).permit(:title, :content)
	end
end
