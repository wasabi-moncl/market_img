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