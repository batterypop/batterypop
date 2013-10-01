class AddPositionToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :position, :integer
  end
end
