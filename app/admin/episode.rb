ActiveAdmin.register Episode do
	menu :parent => "BatteryPOP Shows"
	navigation_menu :show

	
	controller do
		def active_admin_collection
			puts "^^^^^^^^^^^^"
			puts "episode admin collection"
			puts "^^^^^^^^^^^"
			Show.unscoped{super}
		end
		def resource
			puts "^^^^^^^^^^^^"
			puts "episode   resourse"
			puts "^^^^^^^^^^^"
			Show.unscoped{super}
		end
	end

	belongs_to :show

     before_filter :only => [:show, :destroy, :edit, :update] do
		@episode = Episode.friendly.find(params[:id])
	end

	form :html => { :multipart => true } do |e|
		e.inputs "Episode Details" do
			# f.input :show, :as => :select, :member_label => :title, :required => true
			e.input :title, :required => true
			e.input :description, :as => :rich
			e.input :image
			e.input :embed, :as => :select, :member_label => :provider, :required => true
			e.input :video, :label => "Video Code"
		end
		e.actions
	end

end