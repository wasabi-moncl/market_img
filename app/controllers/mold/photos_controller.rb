#encoding: utf-8
class Mold::PhotosController < ApplicationController
  before_filter :the_mold
  def index
    @photos = @mold.photos
    respond_to do |format|
      format.html
      format.json { render json: @mold.photos }
    end
  end


  def show
    @photo = @template.photos.find(params[:id])

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
    photo = @mold.photos.new(params[:photo])
    if photo.save
      @template.photos << photo
      redirect_to mold_positions_path(params[:mold_id])
    # else
    #   render :json => { "errors" => @photos.errors } 
    end
  end
  
  def edit
    @photo = @template.photos.find(params[:id])
  end
  
  def update
    @photo = @mold.photos.find(params[:id])
    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to mold_photos_path(@mold), notice: '이미지 틀 필수 사진 수정됨.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: [@template, @photo].errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @photo = @mold.photos.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to mold_photos_path(@mold) }
      format.json { head :no_content }
    end
  end
end

private 

def the_mold
  @mold = Mold.find(params[:mold_id])
  @template = @mold.template
end