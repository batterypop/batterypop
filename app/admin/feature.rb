ActiveAdmin.register Feature do
	menu :parent => "BatteryPOP Home"

	form do |f|
		f.inputs "BatteryPOP Feature" do
			f.input :title,  :required => true 
			f.input :content,  :as => :rich, :allow_embeds => true
		end
		f.buttons
	end

end