class AddSponsorBannerToggle < ActiveRecord::Migration
  def change
  	add_column :friends, :hide_sponsor_banner, :boolean
  end
end
