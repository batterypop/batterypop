ActiveAdmin.register Sidebar do
  menu :parent => "bPOP Pages", :priority => 1.2, :label => 'Page Sidebars'


  form do |f|
    f.inputs "Sidebar Details" do
      f.input :title, :required => true
      f.input :description
      # f.input :pages, :class => 'chosen', :as => :select, :multiple => true,  :member_label => :title, :through => :pages_sidebars
      f.input :links, :class => 'chosen', :as => :select, :multiple => true, :member_label => :title, collection: Link.urls
    end
    f.actions
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
