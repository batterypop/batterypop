class ChangeCategoriesEpisodesToChannelsEpisodes < ActiveRecord::Migration
  def change
  	rename_table :categories_episodes, :channels_episodes
  	drop_table :categories
  end
end
