class ChangePublicToHiddenForChannels < ActiveRecord::Migration
  def change
  	rename_column :channels, :public, :hidden
  end
end
