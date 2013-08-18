class AddAttachmentImageBackgroundToCreators < ActiveRecord::Migration
  def self.up
    change_table :creators do |t|
      t.attachment :image
      t.attachment :background
    end
  end

  def self.down
    drop_attached_file :creators, :image
    drop_attached_file :creators, :background
  end
end
