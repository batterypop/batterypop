ActiveAdmin.register Avatar do

  menu :parent => "Users", :priority => 1

  form :html => { :multipart => true } do |f|
    f.inputs "Details" do
      f.input :name,  hint: "Only used internally."
      f.input :image, hint: "Avatars should be uploaded as 300x300 PNG's"
    end
    f.actions
  end

  # index do      :as => :rich_picker, :config => { :style => 'width: 400px !important;' }
  #   column :name
  #   column "Image" do |avatar|
  #     link_to image_tag(avatar.image(:thumb)), admin_avatar_path(avatar)
  #   end
  #   default_actions
  # end


index :as => :grid do |avatar|
   link_to image_tag(avatar.image(:thumb)), admin_avatar_path(avatar)
  end


end
