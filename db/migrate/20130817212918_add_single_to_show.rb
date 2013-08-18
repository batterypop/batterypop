class AddSingleToShow < ActiveRecord::Migration
  def change
    add_column :shows, :single, :boolean
  end
end
