class AddLinksToCreator < ActiveRecord::Migration
  def change
    add_column :creators, :google, :string
    add_column :creators, :website, :string
    add_column :creators, :facebook, :string
    add_column :creators, :youtube, :string
  end
end
