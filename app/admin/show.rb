ActiveAdmin.register Show do
	menu :parent => "BatteryPOP Shows", :priority => 1

	before_filter :only => [:show, :destroy, :edit, :update] do
		# @show = Show.friendly.find(params[:id])
		# @show = Show.includes(:episodes).friendly.find(params[:id])
		# @show = Show.friendly.find(params[:id]).includes(:episodes)
		# @show = Show.joins(:episodes).friendly.find(params[:id])
		@show = Show.joins(:episodes).where("episodes.show_id" => :id).includes(:episodes).friendly.find(params[:id])
	end
	
	# controller do
	# 	def active_admin_collection
	# 		Show.unscoped{super}
	# 		Episode.unscoped{super}
	# 	end
	# 	def resource
	# 		Show.unscoped{super}
	# 		Episode.unscoped{super}
	# 	end
	# end




	form  do |f|  
		f.inputs "Show Details" do
			f.input :creator, :as => :select, :member_label => :displayname, :required => true
			f.input :title, :label => "Show Title", :required => true 
			f.input :subtitle, :label => "Show Subtitle", :required => true 
			f.input :image, hint: "Main show image."
			f.input :background, hint: "Main show page background if overridden."
			f.input :description,  :label => "Description", :as => :rich, :allow_embeds => true
			f.input :position, :label => "Show Position"
			f.input :age_range, :as => :select, :collection => get_age_ranges
			f.input :single, :label => "Single episode?", :hint => "Set to true for short or non-episodic video."
			f.input :skiplist, :label => "Hide from Show List.", :hint => "Select this to hide from the show carousel."
			f.input :promote, :label => "Promote on Home Page?.", :hint => "Select this to add to the bottom Promoted carousel."
			f.input :approved, :label => "BatteryPOP approved."
			f.input :created_at
			f.input :updated_at
		end
		 f.inputs "Episodes" do
		 	f.has_many :episodes, :allow_destroy => true do |e|
		 		e.input :episode, :label => "Episode Number", :hint => "Not required for non-episodic show."
		 		e.input :title, :required => true
				e.input :description, :as => :rich
				e.input :duration, :label => "Duration"
				e.input :age_range, :as => :select, :collection => get_age_ranges
				e.input :image
				e.input :embed, :as => :select, :member_label => :provider, :required => true
				e.input :video, :label => "Video Code"
				e.input :approved, :label => "BatteryPOP approved."
				e.input :tag_list, :label => "Tags (seperated by commas)"
				# e.input :_destroy, :as=>:boolean, :required => false, :label=>'Remove'
		 	end

		 end
		 f.inputs "Show Channels" do
			f.input :channels, :as => :check_boxes, :input_html => { :multiple => true } 
		end
		f.buttons
	end

	index do
		column :position
		column :creator, :as => :select, :member_label => :displayname
		# column (:image) {link_to image_tag(@show.image(:thumb)), admin_show_path(@show)}
		column (:image) {|fooimg| image_tag(fooimg.image(:thumb))}
		column :title
		column (:description) { |foobar| raw(foobar.description) }
		column :single, :as => :check_box
		column :approved
		default_actions
	end

	action_item :only => :show do
	    # link_to('View on site', show_path(show))
	    # (show_path(show)).inspect
	end

	# show do
	#  	h3 show.title
	#       div do
	#         simple_format show.description
	#       end
	# end


	 # show do |ad|
  #     attributes_table do
  #       row :title
  #       row :image do
  #         image_tag(ad.image.url)
  #       end
  #     end
  #     active_admin_comments
  #   end


end
