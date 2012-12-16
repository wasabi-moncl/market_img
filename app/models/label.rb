class Label < ActiveRecord::Base
  attr_accessible :color, :column, :font, :height, :kerning, :size, :template_id, :user_id, :width, :x_pos, :y_pos, :part
  belongs_to :user
  belongs_to :template
end
