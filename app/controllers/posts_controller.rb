class PostsController < ApplicationController
  # before_action :is_author?, only: [:edit, :update, :destroy]

  helper_method :is_author?

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.sub_id = params[:sub_id]
    if @post.save
      redirect_to sub_url(@post.sub)
    else
      flash_errors(@post)
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.author_id = current_user.id
    if @post.update(post_params)
      redirect_to sub_url(@post.sub)
    else
      flash_errors(@post)
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post.find(params[:id])
    @post.destroy
    redirect_to sub_url(@post.sub)
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

  def is_author?(post)
    post.author_id == current_user.id
  end

end
