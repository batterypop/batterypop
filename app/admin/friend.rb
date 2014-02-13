ActiveAdmin.register Friend do

  menu :parent => "bPOP Pages", :priority => 4, :label => "Sponsored"

  config.filters = false

  before_filter :only => [:show, :destroy, :edit, :update] do
    @friend = Friend.friendly.find(params[:id])
  end
  

  form do |f|
    f.inputs "Sponsor Details" do
      f.input :title, :required => true
      f.input :sponsor, :required => true
      f.input :description,  :label => "Description", :as => :rich, :allow_embeds => true
      f.input :image,  :hint => f.object.image.present? \
        ? f.template.image_tag(f.object.image.url(:thumb))
        : f.template.content_tag(:span, 'No icon as yet.')
      f.input :background,  :hint => f.object.background.present? \
        ? f.template.image_tag(f.object.background.url(:thumb))
        : f.template.content_tag(:span, 'No background as yet.')
      f.input :episodes, :class => 'chosen', :as => :select, :multiple => true,  :member_label => :title, :through => :featured_episodes
    end
    f.inputs "Featured" do
      f.input :features_autoplay, :label => "Features should autoplay?"
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
    default_actions
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
