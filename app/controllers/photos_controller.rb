class PhotosController < ApplicationController
      
  def write_all
    photos = Photo.all

    photos.each do |x|
      x.write_from_banner
    end

    redirect_to root_url, notice: "Photos was successfully updated."
  end

  def merge_all
    photos = Photo.all
    
    bg_img = Magick::Image.new(780,3000)
    bg_img.background_color = '#ffffff'
      
    photos.each do |x|
      begin
        filename = Rails.root.to_s + '/public/' + x.photo_file.to_s
        
        x_pos = x.position.x_pos
        y_pos = x.position.y_pos
      
        next if x_pos == nil or y_pos == nil
        
        img1 = Magick::ImageList.new(filename)
        
        
        bg_img.composite!(img1, Magick::EastGravity, x_pos, y_pos, Magick::OverCompositeOp)
        
      rescue
        next
      end
    end

    bg_img.format = 'PNG'
    
    bg_img.write('test.png')

    send_data bg_img.to_blob, :filename => "test.png",
    :disposition => 'inline',
    :type => "image/png"
    
  end

  def show
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photo }
    end
  end


  def new
    @photo = Photo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo }
    end
  end


  def create
    @photo = @item.photos.new(params[:photo])
    @photo.user = @item.user
    if @photo.save

    else
      render :json => { "errors" => @photo.errors } 
    end
  end


  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to user_photos_path(@item) }
      format.json { head :no_content }
    end
  end
end

