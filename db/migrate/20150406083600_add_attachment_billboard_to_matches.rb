class AddAttachmentBillboardToMatches < ActiveRecord::Migration
  def self.up
    change_table :matches do |t|
      t.attachment :billboard
    end
  end

  def self.down
    drop_attached_file :matches, :billboard
  end
end
