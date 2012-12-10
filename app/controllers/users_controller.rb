# coding : utf-8
class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def guide
    if session[:village].nil?
      redirect_to root_path, :notice => "city"
    end
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to login_path, :notice => @user.username + "님 가입 감사드립니다!"
    else
      render :new
    end
  end
  
  def show
    @user = User.find params[:id]
    @collections = @user.collections

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end    
  end
  
  def edit
    @user = current_user
    @photos = @user.photos
  end
  
  def update
    photo = params[:photo]
    @photos = Photo.find(photo.keys)
    respond_to do |format|
      if Photo.update(photo.keys, photo.values)
        format.html { redirect_to user_photos_path, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @photos.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # GET /villages
  # GET /villages.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
      format.csv { render csv: @users }
    end
  end
end