ActiveAdmin.register Link do
  menu :parent => "bPOP Pages"

  # filter :associated_visits_id, collection: proc { Visit.all }

  controller do
    def scoped_collection
        # Link.where(link_type: 'url')   hiding all the files; not needed in admin
        super.where(link_type: 'url').order(:created_at)
    end
  end



  form do |f|
    f.inputs "Links" do
      f.input :title
      f.input :url, :required => true
      f.input :link_type, :required => true, collection: ['url', 'file']
      f.input :data
      f.input :created_at, :as => :datetime_select
      # f.has_many :items do |item|
      #   item.input :itemizable_identifier, collection: (Domain.all + Service.all).map { |i| [ i.name, "#{i.class}-#{i.id}"] }
      #   item.input :quantity
      #   item.input :price_per_piece
      # end
    end
    f.actions
  end


  index do
    column :title
    column :url
    column :link_type
    column :created_at
    default_actions
  end

end