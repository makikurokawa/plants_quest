class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def index
    @search = Post.ransack(params[:search])
    @posts = @search.result(distinct: true)
    @posts = Post.all
    if params[:tag_ids]
      @posts = []
      params[tag_ids].each do |key, value|
        if value == "1"
          post_tags = Tag.find_by(tag_name: key).posts
          @posts = @posts.enpty? ? post_tags : @posts & post_tags
        end
      end
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :contents, :status, images: [], post_tags_attributes: [:tag_id, :_destroy])
  end

end


