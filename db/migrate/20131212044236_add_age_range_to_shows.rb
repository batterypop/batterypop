class AddAgeRangeToShows < ActiveRecord::Migration
  def change
    add_column :shows, :age_range, :string
  end
end
