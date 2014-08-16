ActiveAdmin.register Friend do

  menu :parent => "bPOP Pages", :priority => 4, :label => "Sponsored"

  # config.filters = false

  before_filter :only => [:show, :destroy, :edit, :update] do
    @friend = Friend.friendly.find(params[:id])
  end
  

  form do |f|
    f.inputs "Sponsor Details" do
      f.input :title, :required => true
      f.input :sponsor, :required => true
      f.input :approved, :required => true
      f.input :hide_sponsor_banner, :label => "Hide 'SPONSOR' banner?"
      f.input :primary_color, :label => "Main Color:", :hint => "In hexidecimal (ie #ffffff) or 'red'."
      f.input :description,  :label => "Description", :as => :rich, :allow_embeds => true

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

      f.input :episodes, :class => 'chosen', :as => :select, :multiple => true,  :member_label => :chosen_title, :through => :featured_episodes
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

  # action_item  do
  #   link_to('View on site', friend_path(friend)) 
  # end


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


  # index do
  # 	column :username
  # 	column :displayname
  # 	column :bio
  # 	column "Image" do |creator|
  # 		link_to image_tag(creator.image(:thumb)), admin_creator_path(creator)
  # 	end
  # 	column "Background" do |creator|
  # 		link_to image_tag(creator.background(:thumb)), admin_creator_path(creator)
  # 	end
  #   default_actions
  # end

end
