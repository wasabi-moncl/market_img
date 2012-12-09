class Photo < ActiveRecord::Base
  attr_accessible :photo_file, :item_id, :user_id
  belongs_to :item
  belongs_to :user
  
  mount_uploader :photo_file, PhotoUploader
  
end
