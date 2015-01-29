class DropVisits < ActiveRecord::Migration
  def change
  	drop_table :visits
  	remove_column :links, :visits_count
  end
end
