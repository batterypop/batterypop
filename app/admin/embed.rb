ActiveAdmin.register Embed do
	menu :parent => "BatteryPOP Shows"

	form do |f|
		f.inputs "Video Embed Details" do
			f.input :provider, :label => "Provider", :required => true
			f.input :code, :label => "iFrame Embed", :required => true
		end
		f.buttons
	end




 	index :as => :grid do |embed|
		panel embed.provider do
			span	raw(embed.code) + raw("<a href='/admin/embeds/#{embed.id}/edit'>Edit</a>")
		end
	end

end
