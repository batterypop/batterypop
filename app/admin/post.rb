ActiveAdmin.register Post do
	menu :parent => "BatteryPOP Home", :priority => 2

	before_filter :only => [:show, :destroy, :edit, :update] do
		@post = Post.friendly.find(params[:id])
	end

	form do |f|
		f.inputs "Post Details" do
			f.input :title, :label => "Title", :required => true 
			f.input :featured_image, :label => "Featured Image"
			f.input :body, :label => "Body", :as => :rich, :allow_embeds => true
			f.input :tag_list, :label => "Tags (seperated by commas)"
		end
		f.inputs "Categories" do
			f.input :categories, :as => :check_boxes, :input_html => { :multiple => true } 
		end
		f.actions
	end






	index :as => :block do |post|
		panel raw("#{post.created_at.strftime("Posted on %m/%d/%Y %I:%M%p")} <span style='float: right;'>#{link_to('Edit', edit_admin_post_url(post))}  |  #{link_to('Show', admin_post_url(post))}  |  #{link_to('View on Site', post_url(post), :target => '_blank')}  |  #{link_to('Delete', admin_post_url(post), method: :delete, data: {confirm: 'Are you sure you want to delete this?'})}</span>") do
			h2  link_to(post.title, edit_admin_post_url(post))
			div :class => 'post-thumb' do
				raw("<img src='#{post.featured_image(:thumb)}' />")
			end
			div :class => 'admin-post-content' do
				simple_format post.body
			end
			div :class => 'admin-post-meta' do
		       div "Categories: #{post.categories.map { |cat| cat.title }}"
		       div "Tags: #{post.tag_list}"
		     end
		end
	end

	show do |post|
		h4 post.created_at.strftime("%A, %B %d %Y @ %I:%M %p")
		# image_tag(post.featured_image(:original), :class => "img-responsive post-featured-image", :width => '100%')
		post.featured_image
		span do
			 image_tag(post.featured_image(:large), :class => "img-responsive post-featured-image", :width => '100%')
		end
		post.inspect
		div :class => 'post-body' do
			post.body.html_safe
		end
	end


end


#{link_to('Show', show_admin_post_url(post))} 