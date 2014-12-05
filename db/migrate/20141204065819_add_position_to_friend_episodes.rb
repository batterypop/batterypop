class AddPositionToFriendEpisodes < ActiveRecord::Migration
   def change
    add_column :friend_episodes, :position, :integer
  end
end
