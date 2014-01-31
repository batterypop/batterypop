class AddOwnerIdToFeatures < ActiveRecord::Migration
  def change
  	add_column :features, :owner_id, :integer
  	add_column :features, :seconds, :integer
  end
end
