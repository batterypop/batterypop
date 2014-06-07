class FixVisitsCounterCache < ActiveRecord::Migration
	def change
  	add_column :links, :visits_count, :integer, :default => 0
    
    Link.reset_column_information
    Link.all.find_each do |l|
    	Link.reset_counters l.id, :visits
    end
  end
end
