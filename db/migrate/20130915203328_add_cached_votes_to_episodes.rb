class AddCachedVotesToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :cached_votes_total, :integer, :default => 0
    add_column :episodes, :cached_votes_score, :integer, :default => 0
    add_column :episodes, :cached_votes_up, :integer, :default => 0
    add_column :episodes, :cached_votes_down, :integer, :default => 0
    add_index  :episodes, :cached_votes_total
    add_index  :episodes, :cached_votes_score
    add_index  :episodes, :cached_votes_up
    add_index  :episodes, :cached_votes_down
  end
end
