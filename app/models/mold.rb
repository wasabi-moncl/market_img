class Mold < ActiveRecord::Base
  attr_accessible :name, :part, :template_id, :positions_attributes
  belongs_to :template
  belongs_to :element

  has_many :positions
  accepts_nested_attributes_for :positions, :allow_destroy => true
end
