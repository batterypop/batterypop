class RemoveMetaFromShows < ActiveRecord::Migration
  def change
  	remove_column :shows, :meta
  end
end
