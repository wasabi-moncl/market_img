class User::DashboardController < ApplicationController
  def index
    if logged_in?
      @user = current_user
    else
      redirect_to root_path
    end
  end
end
