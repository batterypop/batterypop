class AddDurationToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :duration, :string
    add_column :episodes, :age_range, :string
  end
end
