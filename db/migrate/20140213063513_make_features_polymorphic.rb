class MakeFeaturesPolymorphic < ActiveRecord::Migration
  def change
  	add_column :features, :owner_type,  :string
  end
end
