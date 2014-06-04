class ChangeLinkTypeToData < ActiveRecord::Migration
  def change
  	rename_column :links, :type, :data
  end
end
