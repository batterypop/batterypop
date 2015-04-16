class GlobalHideSponsorTag < ActiveRecord::Migration
  def change
  	add_column :friends, :hide_sponsor_globally, :boolean,  :default => false
  end
end
