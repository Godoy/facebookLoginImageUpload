class Mask < ActiveRecord::Base
  attr_accessible :name, :users_id, :image, :font_file, :font_size, :font_color
  attr_accessible :gravity, :padding_vertical, :padding_horizontal, :interline_spacing

  has_many :users

  has_attached_file :image, :styles => { :medium => "500x500#", :thumb => "200x200#" }
  has_attached_file :font_file

end