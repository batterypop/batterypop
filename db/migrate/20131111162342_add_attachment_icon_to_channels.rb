class AddAttachmentIconToChannels < ActiveRecord::Migration
  def self.up
    change_table :channels do |t|
      t.attachment :icon
    end
  end

  def self.down
    drop_attached_file :channels, :icon
  end
end
