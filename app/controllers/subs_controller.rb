class SubsController < ApplicationController
  before_action :require_is_moderator, only: [:update, :edit]
  helper_method :is_moderator?

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)

    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to subs_url
    else
      flash_errors(@sub)
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to subs_url
    else
      flash_errors(@sub)
      render :edit
    end
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def index
    @subs = Sub.all
  end

  def destroy
    @sub = current_user.subs.find(params[:id])
    @sub.destroy
    redirect_to subs_url
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def is_moderator?(sub)
    sub.moderator_id == current_user.id
  end

  def require_is_moderator
    @sub = Sub.find(params[:id])
    redirect_to subs_url unless is_moderator?(@sub)
  end

end
