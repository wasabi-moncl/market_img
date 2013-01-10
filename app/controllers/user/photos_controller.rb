#encoding: utf-8
class User::PhotosController < ApplicationController
  before_filter :require_login
  def index
    @user = current_user
    @photos = @user.photos.where(:has_code => false).order("created_at desc")
    if @photos.empty?
      redirect_to dashboard_path, notice: '품번을 넣을 이미지 파일이 아직 없습니다.'
    else
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @photos }
      end
    end
  end

  def upload
    @user = current_user
    @photos = current_user.photos.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photos }
    end
  end
  
  def show
    @photo = Photo.find(params[:id])
    @user = current_user

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photo }
    end
  end


  def new
    @user = current_user
    @photo = Photo.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo }
    end
  end


  def create
    @user = current_user
    @photo = Photo.new(params[:photo])
    @photo.user = @user
    if @photo.save
    else
      render :json => { "errors" => @photos.errors } 
    end
    
  end
  
  def edit
    @user = current_user
    @photos = @user.photos.order(:item_code)
  end
  
  def update
    photo = params[:photo]
    @photos = Photo.find(photo.keys)
    respond_to do |format|
      if Photo.update(photo.keys, photo.values)
        Item.association_to_all_photos
        format.html { redirect_to user_items_path, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @photos.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # def update_all
  #   photo = params[:photo]
  #   @photos = Photo.find(photo.keys)
  #   respond_to do |format|
  #     if Photo.update(photo.keys, photo.values)
  #       Item.association_to_all_photos
  #       format.html { redirect_to user_items_path, notice: 'Item was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @photos.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end


  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to user_photos_path }
      format.json { head :no_content }
    end
  end
end
