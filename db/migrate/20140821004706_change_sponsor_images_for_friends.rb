class ChangeSponsorImagesForFriends < ActiveRecord::Migration
  def change
  	add_column :friends, :hide_sponsor_listing, :boolean
  end
end
