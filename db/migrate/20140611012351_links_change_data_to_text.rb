class LinksChangeDataToText < ActiveRecord::Migration
  def change
  	# something got screwed up with the migrations as this was already done
  	change_column :links, :data,  :text
  end
end
