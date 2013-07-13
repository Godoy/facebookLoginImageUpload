class Mask < ActiveRecord::Base
  attr_accessible :name, :users_id
  has_many :users
end
