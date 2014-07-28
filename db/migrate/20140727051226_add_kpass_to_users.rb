class AddKpassToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :kpass_id, :string
  end
end
