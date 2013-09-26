class AddPromotedToShows < ActiveRecord::Migration
  def change
    add_column :shows, :promote, :boolean
    add_column :shows, :skiplist, :boolean
  end
end
