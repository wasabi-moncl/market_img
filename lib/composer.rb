class Composer
  class << self
    def m(mold)
      if mold.photos.where(:part => mold.positions.map(&:part)).empty?
        rails_png = './app/assets/images/rails.png'
        dst = MiniMagick::Image.open(rails_png)
      else
        result_name = 'public/generated_images/mold_' + mold.id.to_s + '_example.png'
        dst = Magick::Image.new(image_width(mold), image_height(mold))
        dst.background_color = "#aaaaaa"
        dst.format = "PNG"
        dst.write(result_name)
        parts = Array.new
        mold.positions.order("part desc").each do |position|
          if mold.photos.where(:part => position.part).count > 0
            parts << {:photo => mold.photos.where(:part => position.part).first, :position => position}
          elsif example_item.photos.where(:part => position.part).count > 0
            parts << {:photo => example_item.photos.where(:part => position.part).first, :position => position}
          end
        end
        parts.each do |part|
          src = MiniMagick::Image.open('public' + part[:photo].photo_file.url)          
          dst = MiniMagick::Image.open(result_name)
          result = dst.composite(src, "png") do |c|
            c.geometry part[:position].geometry
            c.gravity 'NorthWest'
          end
          result.write(result_name)
        end
      end
      result = MiniMagick::Image.open(result_name)
      result.to_blob
    end
    
    def test
      src = MiniMagick::Image.open('public' + Photo.last.photo_file.url)          
      dst = MiniMagick::Image.open('public' + Photo.first.photo_file.url)
      result = src.composite(dst, "png") do |c|
        c.geometry "+100+100"
        c.gravity 'NorthWest'
      end
      result.to_blob      
    end
    
    def item
      example_item
    end
    
    def image_width(mold)
      positions = mold.positions
      x_positions = positions.map(&:x_pos)
      start_point = x_positions.sort.first
      end_points = Array.new
      positions.each do |position|
        x_position = position.x_pos
        if position.width.nil?
          if mold.photos.where(:part => position.part).count > 0
            photo = mold.photos.where(:part => position.part).first
            end_points << Magick::Image.read(photo.photo_file.path).first.columns + x_position
          elsif example_item.photos.where(:part => position.part).count > 0
            photo = example_item.photos.where(:part => position.part).first
            end_points << Magick::Image.read(photo.photo_file.path).first.columns + x_position
          end
        else
          end_points << position.width + x_position
        end
      end
      end_point = end_points.sort.last
      width = end_point - start_point
      width
    end

    def image_height(mold)
      positions = mold.positions
      y_positions = positions.map(&:y_pos)
      start_point = y_positions.sort.first
      end_points = Array.new
      positions.each do |position|
        y_position = position.y_pos
        if position.height.nil?
          if mold.photos.where(:part => position.part).count > 0
            photo = mold.photos.where(:part => position.part).first
            end_points << Magick::Image.read(photo.photo_file.path).first.rows + y_position
          elsif example_item.photos.where(:part => position.part).count > 0
            photo = example_item.photos.where(:part => position.part).first
            end_points << Magick::Image.read(photo.photo_file.path).first.rows + y_position
          end
        else
          end_points << position.height + y_position
        end
      end
      end_point = end_points.sort.last
      height = end_point - start_point
      height
    end
  end
end
private

def example_item
  Item.joins(:photos).group("photos.item_id").having("count(photos.id) > 0").first
end