class AddKpassAccessKeyToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :kpass_access_key, :string
  end
end
