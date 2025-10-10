class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create] # ログインしているかどうかを判断
 
  def index
  @posts = Post.limit(10).order(created_at: :desc)
  end
 
  def new
    @post = Post.new # 新規投稿用のインスタンス変数を用意
  end
 
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
 
    if @post.save
      flash[:notice] = '投稿しました'
      redirect_to posts_path # トップページから投稿一覧ページへ変更
    else
      flash[:alert] = '投稿に失敗しました'
      render :new
    end
  end
 
  def show
    @post = Post.find_by(id: params[:id])
  end
 
  def destroy
  end
 
  private
 
  # ストロングパラメータで許可するカラムを指定
  def post_params
    params.require(:post).permit(:title, :content) # title と content のみ許可
  end
end
