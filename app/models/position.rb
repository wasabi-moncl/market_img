class Position < ActiveRecord::Base
  attr_accessible :height, :name, :part, :template_id, :width, :x_pos, :y_pos
  belongs_to :template
  has_one :photo
end
