ActiveAdmin.register Episode do
	menu :parent => "BatteryPOP Shows"

	 belongs_to :show

	 before_filter :only => [:show] do
        @episode = Episode.friendly.find(params[:id])
      end

	form :html => { :multipart => true } do |f|
		f.inputs "Episode Details" do
			# f.input :show, :as => :select, :member_label => :title, :required => true
			f.input :title
			f.input :description, :as => :rich
			f.input :embed, :as => :select, :label => "Provider", :member_label => :provider,  :required => true
			f.input :video, :required=> true
			f.input :approved, :label => "BatteryPOP approved"
			# f.input :categories, :as => :check_boxes, :input_html => { :multiple => true } 
			# f.input :category,  :as => :select, :collection => Category.all, :input_html => { :multiple => true } 
			  # f.input :category, :as => :check_boxes, :label_method => Proc.new { |category| category.name }  # yes / no ?
			 # f.input :categories, :as => :check_boxes
			# f.input :cateogry_id, :as => :select, :collection => Category.all, :input_html => { :multiple => true } 
		end
		f.inputs "Episode Categories" do
			f.input :categories, :as => :check_boxes, :input_html => { :multiple => true } 
		end
		f.buttons
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
