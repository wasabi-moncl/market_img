#encoding: utf-8
class Template::PhotosController < ApplicationController
  before_filter :the_template
  def index
    @template = Template.find(params[:template_id])
    @photos = @template.photos
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @template.photos }
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
    @template = Template.find(params[:template_id])
    @photo = Photo.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo }
    end
  end


  def create
    @template = Template.find(params[:template_id])
    photo = @template.photos.new(params[:photo])
    photo.part = @template.positions.count
    if photo.save
      @template.positions.create({:part => photo.part, :y_pos => Magick::Image.read(template.photos.all[-2].photo_file.path).first.rows || 1})
      redirect_to template_photos_path(params[:template_id])
    # else
    #   render :json => { "errors" => @photos.errors } 
    end
  end
  
  def edit
    @photo = @template.photos.find(params[:id])
  end
  
  def update
    @photo = @template.photos.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to [@template, @photo], notice: '사진 was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: [@template, @photo].errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @template = Template.find(params[:template_id])
    @photo = @template.photos.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to template_photos_path(@template) }
      format.json { head :no_content }
    end
  end
end


private 

def the_template
  @template = Template.find(params[:template_id])
end
