class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    if user
      login(user)
      # redirect_to ??????
    else
      flash[:errors] = ['Invalid login credentials']
      rander :new
    end
  end

  def destroy
    logout
  end
end