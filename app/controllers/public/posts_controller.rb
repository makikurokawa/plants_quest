class Public::PostsController < ApplicationController
  def new
    Post.new
  end

  def create
    Post.new
  end

  def show
  end

  def index
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:title, :contents, :status)
  end

end


