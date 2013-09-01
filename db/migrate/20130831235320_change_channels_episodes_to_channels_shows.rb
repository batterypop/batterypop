class ChangeChannelsEpisodesToChannelsShows < ActiveRecord::Migration
  def change
  	rename_table :channels_episodes, :channels_shows
  	rename_column :channels_shows, :episode_id, :show_id
  	rename_column :channels_shows, :category_id, :channel_id
  end
end
