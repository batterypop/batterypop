class AddMetaToShows < ActiveRecord::Migration
  def change
    add_column :shows, :meta, :text
  end
end
