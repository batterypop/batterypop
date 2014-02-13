class CreateFriendEpisodes < ActiveRecord::Migration
  def change
    create_table :friend_episodes do |t|
      t.references :friend, index: true
      t.references :episode, index: true

      t.timestamps
    end
  end
end
