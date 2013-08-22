ActiveAdmin.register Show do
	
	form  do |f|  
		f.inputs "Show Details" do
			f.input :creator, :as => :select, :member_label => :displayname, :required => true
			f.input :title, :label => "Show Title", :required => true
			f.input :description,  :label => "Description", :as => :rich
			f.input :single, :label => "Single episode?", :hint => "Set to true for short or non-episodic video."
			f.input :approved, :label => "BatteryPOP approved."
		end
		f.buttons
	end

	index do
		column :creator, :as => :select, :member_label => :displayname
		column :title
		column :description
		column :single, :as => :check_box
		column :approved
		default_actions
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
