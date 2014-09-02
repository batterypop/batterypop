ActiveAdmin.register Link do
  menu :parent => "bPOP Pages"

  form do |f|
    f.inputs "Links" do
      f.input :title
      f.input :url, :required => true
      f.input :link_type, :required => true, collection: ['url', 'file']
      f.input :data

      # f.has_many :items do |item|
      #   item.input :itemizable_identifier, collection: (Domain.all + Service.all).map { |i| [ i.name, "#{i.class}-#{i.id}"] }
      #   item.input :quantity
      #   item.input :price_per_piece
      # end
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
