class ChangeEpisodesToEmbedFields < ActiveRecord::Migration
  def change
  	rename_column :episodes, :video_type, :embed_id
  	change_column :episodes, :embed_id, :string
  	rename_column :episodes, :video_id, :video
  	change_column :episodes, :video, :string
  end
end
