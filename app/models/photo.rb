# encoding: utf-8
class Photo < ActiveRecord::Base
  has_many :banners
  
  attr_accessible :photo_file, :item_id, :user_id, :item_code, :part
  belongs_to :item
  belongs_to :user
  belongs_to :position
  
  mount_uploader :photo_file, PhotoUploader
  
  def write_from_banner
  	banners = Banner.where(:photo_id => self.id )

  	banners.each do |banner|
      filename = Rails.root.to_s + '/public/' + self.photo_file.to_s
      img = Magick::ImageList.new(filename)
      md = Magick::Draw.new
      md.annotate( img, 0, 0, banner.pos_x, banner.pos_y, banner.content) do 
        md.fill      = banner.font_color
        md.pointsize = banner.font_size
        # md.gravity = Magick::CenterGravity
        md.font = Rails.root.to_s + '/public/' + 'NanumGothic.ttf'
      end
      img.write(filename)
    end

  end
  
  def extracted_item_code
    item_code = self[:photo_file]
    item_code = item_code.gsub(/\.(png|jpg|jpeg|gif)+$/, '')
    if item_code =~ /__\d+_$/
      part = /__\d+_$/.match(item_code)[-1]
      part = /\d+/.match(part)[0].to_i
    else
      part = 0  
    end
    item_code = item_code.gsub(/__\d+_$/, '')
    item_code
    result = Hash.new
    result[:item_code] = item_code
    result[:part] = part
    result
  end
end
