class AddAttachmentImageToEpisodes < ActiveRecord::Migration
  def self.up
    change_table :episodes do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :episodes, :image
  end
end
