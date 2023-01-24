class Admin::PostCommentsController < ApplicationController
  def index
    @post = Post.find(params[:post_id])
    @post_comments = @post.comments.all
  end

  def destroy
    post_comment = PostComment.find(params[:id])
    @post = post_comment.post
    post_comment.destroy
    @post_comment = @post.post_comments.all
    render "admin/posts/show"
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
