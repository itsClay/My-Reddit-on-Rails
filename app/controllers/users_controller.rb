class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      # redirect_to 
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy!
    redirect_to new_user_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
