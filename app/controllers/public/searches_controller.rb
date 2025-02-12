class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @users = User.looks(params[:word])
    @posts = Post.looks(params[:word])
  end
end
