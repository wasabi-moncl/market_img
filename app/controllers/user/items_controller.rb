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
      x_pos = part[:position].x_pos
      y_pos = part[:position].y_pos
      # next if x_pos == nil or y_pos == nil
      dst.composite!(src, x_pos, y_pos, Magick::OverCompositeOp)
      dst.write(result_name)
    end
    y = 1200
    label = Magick::Draw.new
    label.annotate( dst, 0, 0, 300, y, item.item_code) do 
      label.fill      = "#ffffff"
      label.pointsize = 20
      # md.gravity = Magick::CenterGravity
      label.font = Rails.root.to_s + '/public/' + 'NanumGothic.ttf'
    end
    label.annotate( dst, 0, 0, 50, y, item.name) do 
      label.fill      = "#ffffff"
      label.pointsize = 20
      # md.gravity = Magick::CenterGravity
      label.font = Rails.root.to_s + '/public/' + 'NanumGothic.ttf'
    end
    label.annotate( dst, 0, 0, 50, y+50, item.laundry) do 
      label.fill      = "#cdca40"
      label.pointsize = 20
      # md.gravity = Magick::CenterGravity
      label.font = Rails.root.to_s + '/public/' + 'NanumGothic.ttf'
    end
    label.annotate( dst, 0, 0, 50, y+100, item.fabric) do 
      label.fill      = "#cdca40"
      label.pointsize = 20
      # md.gravity = Magick::CenterGravity
      label.font = Rails.root.to_s + '/public/' + 'NanumGothic.ttf'
    end

    send_data dst.to_blob, :filename => "product_" + @item.item_code + ".png",
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
