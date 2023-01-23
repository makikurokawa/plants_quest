class Admin::PostCommentsController < ApplicationController
  def index
    @post = Post.find(params[:post_id])
    @post_comments = @post.comments.all
  end

  def destroy
    PostComment.find(params[:post_id]).destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
