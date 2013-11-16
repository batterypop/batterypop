class RemoveSuggestions < ActiveRecord::Migration
  def change
  	drop_table :suggestions
  end
end
