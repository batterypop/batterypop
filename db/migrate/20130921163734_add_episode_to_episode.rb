class AddEpisodeToEpisode < ActiveRecord::Migration
  def change
    add_column :episodes, :episode, :integer
  end
end
