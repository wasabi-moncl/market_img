include MiniGeo
class Label < ActiveRecord::Base
  attr_accessible :color, :column, :font, :height, :kerning, :size, :template_id, :user_id, :position_id, :mold_id, :width, :x_pos, :y_pos, :gravity, :part
  belongs_to :user
  belongs_to :template
  belongs_to :position
  belongs_to :mold
  
  validates_presence_of :color, :column, :font, :size, :x_pos, :y_pos, :gravity
  
end
