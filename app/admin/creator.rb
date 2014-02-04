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
  		f.input :image, hint: "Image to be displayed in show list and header."
  		f.input :background, hint: "Background image if page is to be branded."
      f.input :hidden, :as => :boolean, :label => "Hide Creator page: select if creator page should not be shown."

  	end
  	f.buttons
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
