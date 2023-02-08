class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if params[:post][:is_draft] == "false"
      if @post.save
        redirect_to posts_path
      else
        render :new
      end
    else
      if @post.save
        redirect_to posts_path
      else
        render :new
      end
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.all
  end

  def index
    @posts = Post.page(params[:page]).search(params[:search])
    if params[:tag_ids]
      @posts = []
      params[:tag_ids].each do |key, value|
        if value == "1"
          post_tags = Tag.find_by(tag_name: key).posts
          @posts = @posts.empty? ? post_tags : @posts & post_tags
        end
      end
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :contents,  :is_draft, images: [], post_tags_attributes: [:id, :tag_id, :_destroy])
  end

end


