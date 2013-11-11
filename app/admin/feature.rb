ActiveAdmin.register Feature do
	config.sort_order = "position_asc"
	menu :parent => "BatteryPOP Home"

	form do |f|
		f.inputs "BatteryPOP Feature" do
			f.input :position, :label => "Slide Position"
			f.input :title,  :required => true 
			f.input :content,  :as => :rich, :allow_embeds => true
			f.input :active, :label => "Active?", :hint => "Select for active, unselect to hide."
		end
		f.buttons
	end

	index do
		column :position
		column :title
		column :content
	end

end
