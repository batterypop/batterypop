class AddAttachmentImageBackgroundToShows < ActiveRecord::Migration
  def self.up
    change_table :shows do |t|
      t.attachment :image
      t.attachment :background
    end
  end

  def self.down
    drop_attached_file :shows, :image
    drop_attached_file :shows, :background
  end
end
