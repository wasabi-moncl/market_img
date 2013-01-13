class Composer
  def self.m(mold)
    dst = Magick::Image.new(image_width(mold), image_height(mold))
    # dst.background_color = '#ffffff'
    # dst.format = 'PNG'
    # result_name = 'public/generated_images/generated_' + item.item_code + '.png'
    # dst.write(result_name)
    # parts.each do |part|
    #   filename = 'public' + part[:photo].photo_file.to_s
    #   src = Magick::Image.read(filename)[0]
    #   label = Magick::Draw.new
    #   x_pos = part[:position].x_pos
    #   y_pos = part[:position].y_pos
    #   # next if x_pos == nil or y_pos == nil
    #   dst.composite!(src, x_pos, y_pos, Magick::OverCompositeOp)
    #   dst.write(result_name)
    # end
    # result_image = dst.to_blob
  end
  
  def self.molding
  end
  
  def self.image_width(mold)
    positions = mold.positions
    x_positions = positions.map(&:x_pos)
    start_point = x_positions.sort.first
    end_points = Array.new
    positions.each do |position|
      x_position = position.x_pos
      photo = example_item.photos.where(:part => position.part).first
      if position.width.nil?
        end_points << Magick::Image.read(photo.photo_file.path).first.columns + x_position
      else
        end_points << position.width + x_position
      end
    end
    end_point = end_points.sort.last
    width = end_point - start_point
    width
  end
  
  def self.image_height(mold)
    positions = mold.positions
    y_positions = positions.map(&:y_pos)
    start_point = y_positions.sort.first
    end_points = Array.new
    positions.each do |position|
      y_position = position.y_pos
      photo = example_item.photos.where(:part => position.part).first
      if position.width.nil?
        end_points << Magick::Image.read(photo.photo_file.path).first.rows + y_position
      else
        end_points << position.height + y_position
      end
    end
    end_point = end_points.sort.last
    height = end_point - start_point
    height
  end
end
private

def example_item
  Item.joins(:photos).group("photos.item_id").having("count(photos.id) > 0").first
end