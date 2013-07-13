class AddAttachmentImageToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :image
      t.references :mask
    end
    add_index :users, :mask_id
  end

  def self.down
    drop_attached_file :users, :image
  end
end
