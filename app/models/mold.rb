class Mold < ActiveRecord::Base
  attr_accessible :name, :part, :template_id, :bg_color
  attr_accessible :positions_attributes, :photos_attributes
  belongs_to :template
  has_one :element

  has_many :positions
  has_many :photos
  has_many :labels
  
  accepts_nested_attributes_for :positions, :allow_destroy => true
  accepts_nested_attributes_for :photos, :allow_destroy => true
end
