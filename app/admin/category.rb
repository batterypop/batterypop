ActiveAdmin.register Category do
	menu :parent => "bPOP Pages", :priority => 3, :label => 'bLOG Categories'

	before_filter :only => [:show, :destroy, :edit, :update] do
		@category = Category.friendly.find(params[:id])
	end

	form do |f|
		f.inputs "Blog Category" do
			f.input :title, :label => "Category Title", :required => true 
			f.input :description,  :label => "Description", :as => :rich, :allow_embeds => true
			f.input :parent, :as => :select, :member_label => :title
		end
		f.actions
	end


	index do
		column :title
		column (:description) { |foobar| raw(foobar.description) }
		default_actions
	end

end
