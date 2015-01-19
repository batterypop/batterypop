class AddBackgroundFullToFriends < ActiveRecord::Migration
  def change
  	add_column :friends, :background_full, :boolean, null: false, default: false
  end
end
