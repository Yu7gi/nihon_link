class Public::PostsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def index
    @posts = Post.order(created_at: :desc).page(params[:page]).per(5)
    @genres = Genre.all
  end

  def show
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to mypage_users_path
  end

  private

  def post_params
    params.require(:post).permit(:genre_id, :title, :body)
  end

  def is_matching_login_user
    post = Post.find(params[:id])
    unless post.user_id == current_user.id
      redirect_to posts_path
    end
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
