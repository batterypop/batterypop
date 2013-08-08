class AddParentToUser < ActiveRecord::Migration
  def change
  	add_column :users, :parent_id, :integer, :default => 0, :null => false

  	add_index :users, :parent_id
  end
end
