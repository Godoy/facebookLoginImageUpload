class User < ActiveRecord::Base
  attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid, :image, :phrase, :mask_id

  has_attached_file :image, :styles => { :masked => "500x500#", :thumb => "200x200#" }

  belongs_to :mask

  after_save :apply_image_mask

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end  


  def apply_image_mask
    #logger.debug self.image.path.methods.to_yaml
    #self.image_file_name
    if !self.image.path.nil?
    image = MiniMagick::Image.open(self.image.path(:masked))
    result = image.composite(MiniMagick::Image.open("public/image_masks/mascara04.png", "jpg")) do |c|
      c.gravity "center"
    end

    result.write self.image.path(:masked) #Rails.root.join('public',"my_output_file.jpg")
    end
  end
end
