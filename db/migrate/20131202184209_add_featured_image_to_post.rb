class AddFeaturedImageToPost < ActiveRecord::Migration
  def change
  	add_attachment :posts, :featured_image
  end
end
