class AddPositionAndPublicToChannels < ActiveRecord::Migration
  def change
  	add_column :channels, :public, :boolean
  end
end
