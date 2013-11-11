class AddActiveToFeatures < ActiveRecord::Migration
  def change
    add_column :features, :active, :boolean
  end
end
