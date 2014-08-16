class AddSidebarImageToFriend < ActiveRecord::Migration
  def change
  	add_attachment :friends, :sidebar_image
  end
end
