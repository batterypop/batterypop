ActiveAdmin.register Creator do

  menu :parent => "Users"

  before_filter :only => [:show, :destroy, :edit, :update] do
    @creator = Creator.friendly.find(params[:id])
  end
  

  form  do |f|
  	f.inputs "Creator Details" do
  		f.input :username, hint: "Unique sign in name, no spaces.", :required => true
  		f.input :displayname, hint: "Creator name that displays on page.", :label => "Display Name", :required => true
  		f.input :bio, :as => :rich, :config => { :width => '76%', :height => '400px' }
      f.input :image,  :hint => f.object.background.present? \
        ? f.template.image_tag(f.object.image.url(:thumb))
        : f.template.content_tag(:span, 'No image as yet.')
      f.input :background,  :hint => f.object.background.present? \
        ? f.template.image_tag(f.object.background.url(:thumb))
        : f.template.content_tag(:span, 'No background as yet.')
      f.input :hidden, :as => :boolean, :label => "Hide Creator page: select if creator page should not be shown."

  	end
  	f.actions
  end

  index do
  	column :username
  	column :displayname
  	column :bio
  	column "Image" do |creator|
  		link_to image_tag(creator.image(:thumb)), admin_creator_path(creator)
  	end
  	column "Background" do |creator|
  		link_to image_tag(creator.background(:thumb)), admin_creator_path(creator)
  	end
    default_actions
  end

end
