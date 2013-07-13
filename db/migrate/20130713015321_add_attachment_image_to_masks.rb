class AddAttachmentImageToMasks < ActiveRecord::Migration
  def self.up
    change_table :masks do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :masks, :image
  end
end
