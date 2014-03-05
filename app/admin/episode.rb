ActiveAdmin.register Episode do
	menu :parent => "bPOP Shows"


	# belongs_to :show

     before_filter :only => [:show, :destroy, :edit, :update] do
		@episode = Episode.friendly.find(params[:id])
	end

	form :html => { :multipart => true } do |e|
		e.inputs "Episode Details" do
			# f.input :show, :as => :select, :member_label => :title, :required => true
			e.input :title, :required => true
			e.input :description, :as => :rich
			e.input :image,  :hint => e.object.image.present? \
		        ? e.template.image_tag(e.object.image.url(:thumb)) 
		        : e.template.content_tag(:span, 'No icon as yet.')
		      if e.object.image.present? 
		        e.input :delete_image, as: :boolean, required: :false, label: 'Remove image'
		      end
			e.input :embed, :as => :select, :member_label => :provider, :required => true
			e.input :video, :label => "Video Code"
		end
		e.actions
	end

end