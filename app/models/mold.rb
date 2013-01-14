class Mold < ActiveRecord::Base
  attr_accessible :name, :part, :template_id, :bg_color, :positions_attributes
  belongs_to :template
  belongs_to :element

  has_many :positions
  has_many :photos
  accepts_nested_attributes_for :positions, :allow_destroy => true
  accepts_nested_attributes_for :photos, :allow_destroy => true
end
