ActiveAdmin.register Episode do
	menu :parent => "BatteryPOP Shows"

	 belongs_to :show

	 before_filter :only => [:show] do
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
		e.buttons
	end


	# index do
	# 	# column :creator, :as => :select, :member_label => :displayname
	# 	column :title
	# 	column :description
	# 	column :single
	# 	column :approved
	# 	column :slug
	# 	default_actions
	# end

	# show do
	# 	@episode = Episode.friendly.find(params[:id])
	# end


	# controller do
	# 	defaults :finder =  Episode.friendly.find(params[:id])
	# end
end
