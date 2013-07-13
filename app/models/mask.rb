class Mask < ActiveRecord::Base
  attr_accessible :name, :users_id, :image
  has_many :users

  has_attached_file :image, :styles => { :medium => "500x500#", :thumb => "200x200#" }

end
