ActiveAdmin.register Avatar do

  form :html => { :multipart => true } do |f|
    f.inputs "Details" do
      f.input :name, hint: "Only used internally."
      f.input :image, hint: "Avatars should be uploaded as 300x300 PNG's"
    end
    f.buttons
  end

  index do
    column :name
    column "Image" do |avatar|
      link_to image_tag(avatar.image(:thumb)), admin_avatar_path(avatar)
    end
    default_actions
  end



end
