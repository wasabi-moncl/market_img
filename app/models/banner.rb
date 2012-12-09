class Banner < ActiveRecord::Base
  attr_accessible :bg_color, :content, :font_color, :font_size, :photo_id, :pos_x, :pos_y
end
