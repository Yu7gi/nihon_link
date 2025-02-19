class Public::SearchesController < ApplicationController

  def search
    @users = User.looks(params[:word])
    @posts = Post.looks(params[:word])
    @groups = Group.looks(params[:word])
  end
end
