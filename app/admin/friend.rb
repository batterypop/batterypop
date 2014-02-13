ActiveAdmin.register Friend do

  menu :parent => "Users"

  config.filters = false

  before_filter :only => [:show, :destroy, :edit, :update] do
    @friend = Friend.unscoped.includes(:episodes, :features).friendly.find(params[:id])
  end
  

  form do |f|
    f.inputs "Sponsor Details" do
      f.input :title, :required => true
      f.input :sponsor, :required => true
      f.input :description,  :label => "Description", :as => :rich, :allow_embeds => true
      f.input :image, hint: "Icon image."
      f.input :background, hint: "Page background if overridden."
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

  # form  do |f|
  # 	f.inputs "Creator Details" do
  # 		f.input :username, hint: "Unique sign in name, no spaces.", :required => true
  # 		f.input :displayname, hint: "Creator name that displays on page.", :label => "Display Name", :required => true
  # 		f.input :bio, :as => :rich, :config => { :width => '76%', :height => '400px' }
  # 		f.input :image, hint: "Image to be displayed in show list and header."
  # 		f.input :background, hint: "Background image if page is to be branded."
  #     f.input :hidden, :as => :boolean, :label => "Hide Creator page: select if creator page should not be shown."

  # 	end
  # 	f.actions
  # end

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
