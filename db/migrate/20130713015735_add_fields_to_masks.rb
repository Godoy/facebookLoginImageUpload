class AddFieldsToMasks < ActiveRecord::Migration
  def self.up
    change_table :masks do |t|
      t.attachment :font_file
      t.integer :font_size, :default => 26
      t.string :font_color
      t.string :gravity, :default => "North"
      t.integer :padding_vertical, :default => 0
      t.integer :padding_horizontal, :default => 0
      t.integer :interline_spacing, :default => 5
    end
  end

  def self.down
    drop_attached_file :masks, :font_file
  end
end
