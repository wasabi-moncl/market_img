#encoding: utf-8
class User::ItemsController < ApplicationController
  def show
  end
  
  def html_code
    @brand = Brand.find(params[:id])
    @item = @brand.items.where(:item_code => params[:item_code]).first
  end

  def index
    @items = current_user.items.order("created_at desc")
    if current_user.brand.nil?
      redirect_to edit_user_path(current_user), notice: '사용자 정보 수정페이지입니다. 브랜드를 선택해주세요.'
    elsif current_user.items.empty?
      redirect_to first_user_items_path, notice: '1번 단계로 되돌아왔습니다. 먼저, 엑셀 파일을 업로드해주세요.'
    elsif current_user.photos.empty?
      redirect_to new_user_photo_path, notice: '2번 단계로 되돌아왔습니다. 먼저, 상품 사진을 업로드해주세요.'
    elsif current_user.brand.templates.empty?
      redirect_to dashboard_path, notice: '템플릿이 만들어지지 않았습니다. 담당 직원에게 연락주세요.'
    else
      respond_to do |format|
        format.html
        format.csv { send_data @item.to_csv }
        # format.xls
      end
    end
  end
  
  def product_image
    item = Item.find(params[:id])
    parts = item.parts
    dst = Magick::Image.new(780,item.image_height(current_user))
    dst.background_color = '#ffffff'
    dst.format = 'PNG'
    result_name = 'public/generated_images/generated_' + item.item_code + '.png'
    dst.write(result_name)
    parts.each do |part|
      filename = 'public' + part[:photo].photo_file.to_s
      src = Magick::Image.read(filename)[0]
      label = Magick::Draw.new
      current_user.brand.templates.last.labels.find_all_by_part(part[:photo].part).each do |part_label|
        begin
          gravity = ("Magick::" + part_label.gravity + "Gravity").constantize
        rescue
          gravity = Magick::NorthGravity
        end
        unless item[part_label.column.to_sym].nil?
          label.annotate(src, 0, 0, part_label.x_pos, part_label.y_pos, item.send(part_label.column)) do 
            label.fill      = part_label.color
            label.pointsize = part_label.size.to_i
            label.gravity = gravity
            label.font = Rails.root.to_s + '/public/' + 'NanumGothic.ttf'
          end
        end
      end
      x_pos = part[:position].x_pos
      y_pos = part[:position].y_pos
      # next if x_pos == nil or y_pos == nil
      dst.composite!(src, x_pos, y_pos, Magick::OverCompositeOp)
      dst.write(result_name)
    end
    result_image = dst.to_blob
    
    send_data result_image, :filename => "product_" + item.item_code + ".png",
    :disposition => 'inline', :type => "image/png"
  end
  
  def saved_image
    item = Item.find(params[:id])
    result_name = 'public/generated_images/generated_' + item.item_code + '.png'
    if File.exist?(result_name)
      respond_to do |format|
        format.png do 
          send_data File.read(result_name), :filename => "product_" + item.item_code + ".png",
          :disposition => 'inline', :type => "image/png"
        end
      end
    else
      redirect_to product_image_item_path(item)
    end
  end
  
  def first
    
  end

  def import
    Item.import(params[:file], current_user)
    unless current_user.brand.templates.empty?
      Item.association_to_the_template(current_user)
      redirect_to new_user_photo_path, notice: '상품 정보가 입력되었습니다.'
    else
      redirect_to dashboard_path, notice: '템플릿이 아직 준비되지 않았습니다. 관리자에게 연락 바랍니다.'
    end
  end
  
  def edit
    @item = current_user.items.find(params[:id])
  end

  def destroy
  end

  def update
  end

  def create
  end
end
