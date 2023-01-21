class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if params[:post]
      if @post.save(context: :publicize)
        redirect_to posts_path, notice: "投稿しました！"
      else
        render :new, alert: "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    else
      if @post.update(is_draft: true)
        redirect_to users_mypage_path, notice: "下書きを保存しました！"
      else
        render :new, alert: "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
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
      if params[:publicize_draft]
        @post.attributes = post_params.merge(is_draft: false)
        if @post.save(context: :publicize)
          redirect_to post_path(@post.id), notice: "下書きを公開しました！"
        else
          @post.is_draft = true
          render :edit, alert: "公開できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
        end
      elsif params[:update_post]
        @post.attributes = post_params
        if @post.save(context: :publicize)
          redirect_to post_path(@post.id), notice: "更新しました！"
        else
          render :edit, alert: "更新できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
        end
      else
        if @post.update(post_params)
          redirect_to post_path(@post.id), notice: "下書きを更新しました！"
        else
          render :edit, alert: "更新できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
        end
      end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :contents, :status, :is_draft, images: [], post_tags_attributes: [:tag_id, :_destroy])
  end

end


