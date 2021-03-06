ActiveAdmin.register Channel do
	menu :parent => "bPOP Shows"

	before_filter :only => [:show, :destroy, :edit, :update] do
		@channel = Channel.friendly.find(params[:id])
	end


	controller do
		def update
			super
			 expire_fragment("shows_channels_home")
		end

		def destroy
			super
			 expire_fragment("shows_channels_home")
		end

		def create
			super
			 expire_fragment("shows_channels_home")
		end
	end

	form do |f|
		f.inputs "BatteryPOP Channel" do
			f.input :position, :label => "Channel Position", :required => true
			f.input :title, :label => "Channel Title", :required => true 
			f.input :description,  :label => "Description", :as => :rich, :allow_embeds => true
			f.input :icon
			f.input :hidden, :label => "Select to hide channel from channel list."
			f.input :parent, :as => :select, :member_label => :title
		end
		f.actions
	end


	index do
		column :position
		column :title
		column (:description) { |foobar| raw(foobar.description) }
		column :hidden
		default_actions
	end


end
