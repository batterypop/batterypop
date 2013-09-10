class AddSubtitleToShow < ActiveRecord::Migration
  def change
  	add_column :shows, :subtitle, :string
  end
end
