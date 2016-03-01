class AddSortTitleToShows < ActiveRecord::Migration
  def change
  	add_column :shows, :sort_title, :string
  end
end
