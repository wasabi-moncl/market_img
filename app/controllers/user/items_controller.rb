require "RMagick"

class User::ItemsController < ApplicationController
  def show
  end

  def index
    @items = Item.order(:item_code)
    respond_to do |format|
      format.html
      format.csv { send_data @item.to_csv }
      # format.xls
    end
  end
  
  def product_image
    item = Item.find(params[:id])
    parts = item.parts
    dst = Magick::Image.new(780,2500)
    dst.background_color = '#ffffff'
    dst.format = 'PNG'
    result_name = 'public/generated_images/generated_' + item.item_code + '.png'
    dst.write(result_name)

    parts.each do |part|
      filename = 'public' + part[:photo].photo_file.to_s
      src = Magick::Image.read(filename)[0]
      label = Magick::Draw.new
      item.templates.first.labels.find_all_by_part(part[:photo].part).each do |part_label|
        label.annotate(src, 0, 0, part_label.x_pos, part_label.y_pos, item[part_label.column.to_sym]) do 
          label.fill      = part_label.color
          label.pointsize = part_label.size.to_i
          # md.gravity = Magick::CenterGravity
          label.font = Rails.root.to_s + '/public/' + 'NanumGothic.ttf'
        end
      end
      x_pos = part[:position].x_pos
      y_pos = part[:position].y_pos
      # next if x_pos == nil or y_pos == nil
      dst.composite!(src, x_pos, y_pos, Magick::OverCompositeOp)
      
      
      dst.write(result_name)
    end

    send_data dst.to_blob, :filename => "product_" + item.item_code + ".png",
      :disposition => 'inline', :type => "image/png"
  end

  def import
    Item.import(params[:file])
    Item.association_to_the_template
    redirect_to user_items_path
  end
  
  def edit
  end

  def destroy
  end

  def update
  end

  def create
  end
end
