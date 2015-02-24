class AddCustomAdsToFriends < ActiveRecord::Migration
  def change
  	add_column :friends, :dfp_header_code, :text
  	add_column :friends, :dfp_banner_ad, :text
  	add_column :friends, :dfp_mid_side_ad, :text
  end
end
