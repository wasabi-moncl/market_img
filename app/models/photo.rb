# encoding: utf-8
class Photo < ActiveRecord::Base
  has_many :banners
  
  attr_accessible :photo_file, :item_id, :user_id, :item_code, :part
  belongs_to :item
  belongs_to :user
  
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
  
end
