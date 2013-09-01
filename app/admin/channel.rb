ActiveAdmin.register Channel do
	menu :parent => "BatteryPOP Shows"

	before_filter :only => [:show, :destroy] do
		@channel = Channel.friendly.find(params[:id])
	end



end
