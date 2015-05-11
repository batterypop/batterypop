class AddBannerCodeToTournaments < ActiveRecord::Migration
  def change
	add_column :tournaments, :dfp_header_code, :text
  	add_column :tournaments, :dfp_banner_ad, :text
  end
end
