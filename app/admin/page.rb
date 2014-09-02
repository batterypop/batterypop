ActiveAdmin.register Page do
  menu :parent => "bPOP Pages", :priority => 1, :label => 'Pages'

  before_filter :only => [:show, :destroy, :edit, :update] do
    @page = Page.friendly.find(params[:id])
  end


  form do |f|
    f.inputs "Page Details" do
      f.input :title, :required => true
      f.input :slug
      f.input :content, :as => :rich, :allow_embeds => true
      f.input :sidebars, :class => 'chosen', :as => :select, :multiple => true,  :member_label => :title, :through => :pages_sidebars
    end
    f.actions
  end

  index do
    column :title
    column :slug
    column :content
    
    column "" do |resource|
      links = ''.html_safe
      links += link_to I18n.t('active_admin.view'), resource_path(resource), :class => "member_link show_link"
      links += link_to I18n.t('active_admin.edit'), edit_resource_path(resource), :class => "member_link edit_link"
      links += link_to I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), :class => "member_link delete_link"
      links += link_to 'Site View', "/" + resource.slug, :target => '_blank'
      links
    end
  end
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
