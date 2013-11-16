class FeatureController < ApplicationController
	before_action :set_category, only: [:show]

	def index
		@features = Feature.active
		# render "featured"
		render :partial => "layouts/featured", :collection => @features

	end
end