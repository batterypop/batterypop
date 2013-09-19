class AddSlugToCreatorAndUser < ActiveRecord::Migration
  def change
  	add_column :creators, :slug, :string
  	add_column :users, :slug, :string
  end
end
