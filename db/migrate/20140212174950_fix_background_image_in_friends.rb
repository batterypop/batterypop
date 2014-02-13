class FixBackgroundImageInFriends < ActiveRecord::Migration
  def change
  	rename_column :friends, :background_image_file_name, :background_file_name
  	rename_column :friends, :background_image_content_type, :background_content_type
  	rename_column :friends, :background_image_file_size, :background_file_size
  	rename_column :friends, :background_image_updated_at, :background_updated_at
  end
end
