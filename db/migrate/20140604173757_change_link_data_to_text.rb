class ChangeLinkDataToText < ActiveRecord::Migration
  def change
  	change_column :links, :data, :text
  end
end
