class User::PhotosController < ApplicationController
  before_filter :the_user
  
  def index
    @photos = @user.photos.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user.photos }
    end
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
    @photos = @user.photos.new(params[:photo])
    if @photos.save
      # format.html { redirect_to user_photos_path, notice: 'Item was successfully updated.' }
      # format.json { head :no_content }
      redirect_to user_photos_path
    # else
    #   render :json => { "errors" => @photos.errors } 
    end
  end
  
  def edit
    @photos = @user.photos
  end
  
  def update
    @photos = @user.photos.find(params[:photo_ids])
    respond_to do |format|
      if @photos.update_attributes(params[:photos_ids])
        format.html { redirect_to @photos, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @photos.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to gallery_photos_path(@item) }
      format.json { head :no_content }
    end
  end
end


private 

def the_user
  if logged_in?
    @user = current_user
  else
    redirect_to login_path
  end
end
