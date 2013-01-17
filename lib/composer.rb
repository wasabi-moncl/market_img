class Composer
  class << self
    def combine(item = example_item, mold)
    # def c(item = example_item, mold = Mold.last)
      result_name = 'public/generated_images/item_' + item.id.to_s + '_mold_' + mold.id.to_s + '.png'
      dst = Magick::Image.new(image_width(mold), image_height(mold))
      dst.background_color = "#aaaaaa"
      dst.format = "PNG"
      dst.write(result_name)
      mold.positions.order("part desc").each do |position|
        dst = MiniMagick::Image.open(result_name)
        src = labeling(item, position)
        geo = position.geo
        result = dst.composite(src, "png") do |c|
          c.geometry geo
          c.gravity 'NorthWest'
        end
        result.write(result_name)        
      end
      result = MiniMagick::Image.open(result_name)
    end
    
    def annotated_mold_preview(item = example_item, mold)
      combine(item, mold).to_blob
    end
    
    def molding(item = example_item, mold)
      if mold.photos.where(:part => mold.positions.map(&:part)).empty?
        rails_png = './app/assets/images/rails.png'
        result_name = rails_png
      else
        result_name = 'public/generated_images/mold_' + mold.id.to_s + '_example.png'
        dst = Magick::Image.new(image_width(mold), image_height(mold))
        dst.background_color = "#aaaaaa"
        dst.format = "PNG"
        dst.write(result_name)
        parts = Array.new
        mold.positions.order("part desc").each do |position|
          if mold.photos.where(:part => position.part).count > 0
            parts << {:photo => mold.photos.where(:part => position.part).first, :geometry => position.geo}
          elsif item.photos.where(:part => position.part).count > 0
            parts << {:photo => item.photos.where(:part => position.part).first, :geometry => position.geo}
          end
        end
        parts.each do |part|
          geo = part[:geometry]
          puts geo
          src = MiniMagick::Image.open('public' + part[:photo].photo_file.url)          
          dst = MiniMagick::Image.open(result_name)
          result = dst.composite(src, "png") do |c|
            c.geometry geo
            c.gravity 'NorthWest'
          end
          result.write(result_name)
        end
      end
      result = MiniMagick::Image.open(result_name)
    end
    
    def labeling(item = example_item, position)
      # if position.labels.empty?
      #   rails_png = './app/assets/images/rails.png'
      #   result_name = rails_png
      # else
        result_name = 'public/generated_images/position' + position.id.to_s + '_label_example_.png'
        photo = nil
        photo = position.mold.photos.where(:part => position.part).first unless position.mold.photos.where(:part => position.part).empty?
        if photo.nil?
          photo = item.photos.where(:part => position.part).first unless item.photos.where(:part => position.part).empty?
        end
        src = MiniMagick::Image.open('public' + photo.photo_file.url)
        src.write(result_name)
        unless position.labels.empty?
          position.labels.each do |label|
            src = MiniMagick::Image.open(result_name)
            src.combine_options do |c|
              c.font Rails.root.to_s + '/public/' + 'NanumGothic.ttf'
              c.pointsize label.size
              c.gravity label.gravity
              c.fill label.color
              c.draw "text " + label.geo + " '" + item.send(label.column) + "'"
            end
            src.write(result_name)
          end
        end
      # end
      result = MiniMagick::Image.open(result_name)
    end
    
    def mold_preview(item = item, mold)
      molding(item, mold).to_blob
    end

    def label_preview(item = example_item, position)
      labeling(item, position).to_blob
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