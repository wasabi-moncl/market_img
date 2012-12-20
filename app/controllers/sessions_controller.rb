# coding : utf-8

class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to dashboard_path
    end
  end
  
  def create
    user = login(params[:username], params[:password], params[:remember_me])
    if user
      redirect_to root_path, :notice => "로그인 되었습니다."
    else
      flash.now.alert = "계정 정보가 잘못 입력되었습니다."
      render "new"
    end
  end
  
  def destroy
	  logout
	  redirect_to root_url, :notice => "로그아웃 되었습니다."
	end
  
end