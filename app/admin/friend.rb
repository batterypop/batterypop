ActiveAdmin.register Friend do
  menu :parent => "bPOP Pages", :priority => 4, :label => "Sponsored"

  # config.filters = false

  before_filter :only => [:show, :destroy, :edit, :update] do
    @friend = Friend.includes(:episodes).friendly.find(params[:id])
    @startOrder = !(@friend.nil?) ? @friend.friend_episodes.map(&:episode_id).join(',') : ""
  end
  

  form do |f|
    f.inputs "Sponsor Details" do
      f.input :title, :required => true
      f.input :sponsor
      f.input :approved, :required => true
      f.input :hide_sponsor_banner, :label => "Hide 'SPONSOR' in breadcrumb?"
      f.input :hide_sponsor_listing, :label => "Hide 'SPONSOR' in Sponsor episode list?"
      f.input :primary_color, :label => "Main Color:", :hint => "In hexidecimal (ie #ffffff) or 'red'."
      f.input :description,  :label => "Description", :as => :rich, :allow_embeds => true

      f.input :created_at, :as => :datetime_select

      f.input :image,  :hint => f.object.image.present? \
        ? f.template.image_tag(f.object.image.url(:thumb)) 
        : f.template.content_tag(:span, 'No icon as yet.')
      if f.object.image.present? 
        f.input :delete_image, as: :boolean, required: :false, label: 'Remove image'
      end

      f.input :sidebar_image,  :hint => f.object.sidebar_image.present? \
        ? f.template.image_tag(f.object.sidebar_image.url(:thumb)) 
        : f.template.content_tag(:span, 'No icon as yet.')
      if f.object.sidebar_image.present? 
        f.input :delete_sidebar_image, as: :boolean, required: :false, label: 'Remove image'
      end

       f.input :sidebar_image_link, :label => "URL for Sidebar?"


      f.input :background,  :allow_destroy => true,  :hint => f.object.background.present? \
        ? f.template.image_tag(f.object.background.url(:thumb))
        : f.template.content_tag(:span, 'No background as yet.')
      if f.object.background.present? 
        f.input :delete_background, as: :boolean, required: :false, label: 'Remove image'
      end

    #  f.input :episodes, :class => 'select2', :as => :select, :multiple => true,  :member_label => :chosen_title, :through => :featured_episodes
    #  :collection => Episode.map {|e| [e.chosen_title, e.id, e.thumb]}
    #  
      f.input :episodes,  :as => :select, :multiple => true, :through => :featured_episodes
      
      f.form_buffers.last << hidden_field_tag("s2_episode_order", !(f.object.nil?) ? f.object.friend_episodes.map(&:episode_id).join(',') : "")

    end

    f.inputs "Featured" do
      f.input :features_autoplay, :label => "Features should autoplay?"
      f.input :features_exit, :label => "Features exit on end?", :as => :select, :collection => ['automatic', 'close']
      f.has_many :features, :allow_destroy => true do |e|
        e.input :position, :label => "Slide Position"
        e.input :title,  :required => true 
        e.input :content,  :as => :rich, :allow_embeds => true
        e.input :seconds, :label => "Time", :hint => "Time in milliseconds."
        e.input :active, :label => "Active?", :hint => "Select for active, unselect to hide."
      end
    end
    f.actions
  end

 

  index do
    column :title
    column :approved
    column "Image" do |creator|
      link_to image_tag(creator.image(:thumb)), admin_creator_path(creator)
    end
    column :features_autoplay
    # default_actions
    column "" do |resource|
      links = ''.html_safe
      links += link_to I18n.t('active_admin.view'), resource_path(resource), :class => "member_link show_link"
      links += link_to I18n.t('active_admin.edit'), edit_resource_path(resource), :class => "member_link edit_link"
      links += link_to I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), :class => "member_link delete_link"
      links += link_to 'Site View', friend_path(resource)
      links
    end
  end


  controller do
    def update(options={}, &block)
      @order = params['s2_episode_order'].split(",").map(&:to_i)
  
      # This sets the attr_accessor you want later
      # params[:baz].merge!({ :last_foobar => current_foobar })
      # This is taken from the active_admin code
      super do |success, failure| 
        block.call(success, failure) if block
        failure.html { render :edit }
      end

      @order.each_with_index do |id, pos|
        @fe = FriendEpisode.where(:friend_id => @friend.id, :episode_id => id).first
        @fe.position = pos
        @fe.save
      end

    end


   
  end



end
