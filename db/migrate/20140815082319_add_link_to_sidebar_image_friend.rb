class AddLinkToSidebarImageFriend < ActiveRecord::Migration
  def change
  	add_column :friends, :sidebar_image_link, :string
  end
end
