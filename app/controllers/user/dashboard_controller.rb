class User::DashboardController < ApplicationController
  def index
    begin
      if logged_in?
        @user = current_user
      else
        redirect_to root_path
      end
    rescue ActiveRecord::RecordNotFound
      session[:user_id] = nil
    end
  end
end
