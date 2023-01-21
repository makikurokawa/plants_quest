class Admin::PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = @post.post_comments.all
  end

  def destroy
    @post = Post.find(params[:id])
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    redirect_to admin_post_path(@post.id)
  end
end
