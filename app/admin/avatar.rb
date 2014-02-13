ActiveAdmin.register Avatar do

  menu :parent => "Users", :priority => 1

  form :html => { :multipart => true } do |f|
    f.inputs "Details" do
      f.input :name,  hint: "Only used internally."
      f.input :image,  :hint => f.object.image.present? \
        ? f.template.image_tag(f.object.image.url(:thumb))
        : f.template.content_tag(:span, 'No image as yet.')
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
  # links = ''.html_safe
  #       links += link_to I18n.t('active_admin.view'), resource_path(resource), :class => "member_link show_link"
  #       links += link_to I18n.t('active_admin.edit'), edit_resource_path(resource), :class => "member_link edit_link"
  #       links += link_to I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), :class => "member_link delete_link"
        
  panel link_to avatar.name, admin_avatar_path(avatar)
   link_to image_tag(avatar.image(:thumb)), admin_avatar_path(avatar)
  end


end
