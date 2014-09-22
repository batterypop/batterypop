ActiveAdmin.register Embed do
	menu :parent => "bPOP Shows"

	form do |f|
		f.inputs "Video Embed Details" do
			f.input :provider, :label => "Provider", :required => true
			f.input :needs_permission
			f.input :code, :label => "iFrame Embed", :required => true
		end
		f.actions
	end




 	index :as => :grid do |embed|
		panel embed.provider do
			span	raw(embed.code) + raw("<a href='/admin/embeds/#{embed.id}/edit'>Edit</a>")
		end
	end

end
