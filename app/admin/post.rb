ActiveAdmin.register Post do
	menu :parent => "BatteryPOP Home", :priority => 2

	before_filter :only => [:show, :destroy, :edit, :update] do
		@post = Post.friendly.find(params[:id])
	end

	form do |f|
		f.inputs "Post Details" do
			f.input :title, :label => "Title", :required => true 
			f.input :body, :label => "Body", :as => :rich, :allow_embeds => true
		end
		f.inputs "Categories" do
			f.input :categories, :as => :check_boxes, :input_html => { :multiple => true } 
		end
		f.buttons
	end




	index do
		column (:featured_image) {|fooimg| image_tag(fooimg.featured_image(:thumb))}
		column :title
		column (:body) { |foobar| raw(foobar.body) }
		default_actions
	end

end
