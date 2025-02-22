class HomesController < ApplicationController
  def top
    @posts = Post.order(created_at: :desc).limit(3)
    @genres = Genre.all
  end

  def about
  end
end
