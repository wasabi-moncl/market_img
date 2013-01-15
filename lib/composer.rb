class Composer
  class << self
    def m(mold)
      if mold.photos.where(:part => mold.positions.map(&:part)).empty?
        rails_png = './app/assets/images/rails.png'
        dst = MiniMagick::Image.open(rails_png)
      else
        result_name = 'public/generated_images/mold_' + mold.id.to_s + '_example.png'
        dst = Magick::Image.new(image_width(mold), image_height(mold))
        dst[0].background_color = "#aaaaaa"
        dst.format = "PNG"
        dst.write(result_name)
        mold.positions.order("part desc").each do |position|
          unless mold.photos.where(:part => position.part).empty?
            photo = mold.photos.where(:part => position.part).first
          else
            photo = example_item.photos.where(:part => position.part).first
          end
          src = MiniMagick::Image.open('public' + photo.photo_file.url)
          dst = MiniMagick::Image.open(result_name)
          result = dst.composite(src, "png") do |c|
            c.geometry ''
            c.gravity 'NorthEast'
          end
          # end
          # result.write(result_name)
        end
      end
      dst.to_blob
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