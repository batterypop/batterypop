ActiveAdmin.register Embed do
	menu :parent => "Shows"

	form do |f|
		f.inputs "Video Embed Details" do
			f.input :provider, :label => "Provider", :required => true
			f.input :code, :label => "iFrame Embed", :required => true
		end
		f.buttons
	end

end
