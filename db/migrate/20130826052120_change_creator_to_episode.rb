class ChangeCreatorToEpisode < ActiveRecord::Migration
  def change
  	rename_column :episodes, :creator_id, :slug
  	change_column :episodes, :slug, :string
  	add_index :episodes, :slug, unique: true
  end
end
