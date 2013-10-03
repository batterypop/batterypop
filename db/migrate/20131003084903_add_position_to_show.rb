class AddPositionToShow < ActiveRecord::Migration
  def change
    add_column :shows, :position, :integer
  end
end
