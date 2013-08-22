ActiveAdmin.register Episode do
	 menu :parent => "Shows"

	form :html => { :multipart => true } do |f|
		f.inputs "Episode Details" do
			f.input :title
			f.input :description, :as => :rich
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

end
