class Public::SearchesController < ApplicationController

  def search
    @users = User.looks(params[:word])
    @posts = Post.looks(params[:word])
    @groups = Group.looks(params[:word])
  end

  def genre_search
    @genres = Genre.all
    @genre_id = params[:genre_id]
    @posts = Post.where(genre_id: @genre_id).page(params[:page]).per(5)
  end
end
