class PhotosController < ApplicationController
        
  def write_all
    photos = Photo.all

    photos.each do |x|
      x.write_from_banner
    end

    redirect_to root_url, notice: "Photos was successfully updated."
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

