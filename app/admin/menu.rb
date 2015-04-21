ActiveAdmin.register Menu do
  menu :parent => "bPOP Pages"

  form do |f|
    f.inputs "Menu Item" do
      f.input :position, :label => "Menu Position"
      f.input :title, :required => true, :label => "Title" 
      f.input :url, :required => true, :label => "Relative URL"
      f.input :active, :label => "Active"
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