class AddHiddenToCreators < ActiveRecord::Migration
  def change
  	add_column :creators, :hidden, :boolean
  end
end
