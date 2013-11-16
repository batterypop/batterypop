ActiveAdmin.register Suggestion do
	menu :parent => "BatteryPOP Shows"

	form do |f|
		f.inputs "Episode Suggestions" do
			f.input :episode, :member_label => :title, :required => true
			f.input :related_episode, :member_label => :title, :required => true
		end
		f.buttons
	end

end