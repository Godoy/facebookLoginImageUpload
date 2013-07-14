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
    logger.debug self.mask.to_yaml
    #self.image_file_name

#gravity: NorthWest, North, NorthEast, West, Center, East, SouthWest, South, or SouthEast
    if !self.image.path.nil?

      img = MiniMagick::Image.open(self.image.path(:masked))

      img.combine_options do |c|
        c.gravity self.mask.gravity #'NorthWest'
        c.fill self.mask.font_color #'#ffffff'
        #c.stroke 'black'
        #c.strokewidth '2'
        c.pointsize self.mask.font_size #'26'
        c.interline_spacing self.mask.interline_spacing #'5'
        c.font self.mask.font_file.path #{}"public/fonts/comic-sans.ttf" 
        c.annotate "+#{self.mask.padding_vertical}+#{self.mask.padding_horizontal}", clean_msg(self.phrase)
        
      end


      path_mask = self.mask.image.path(:medium)
      img = img.composite(MiniMagick::Image.open(path_mask, "jpg")) do |c|
        c.gravity "center"
      end

      img.write self.image.path(:masked) #"public/teste.png"

    end
  end

  private
  def clean_msg(text)
    wrapped_text = word_wrap text
    escape_quotes wrapped_text
  end
  
  def word_wrap(text, col = 27)
    wrapped = text.gsub(/(.{1,#{col + 4}})(\s+|\Z)/, "\\1\n")
    wrapped.chomp!
  end

  def escape_quotes(text)
    text.gsub(/"/, "''")
  end
end
