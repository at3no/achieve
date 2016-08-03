class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  def index
    @blogs = Blog.all
  end
  
  def new
    if params[:back]
     @blog = Blog.new(blogs_params)
    else
      @blog = Blog.new
    end
  end

  def create
    @blog = Blog.new(blogs_params)
    @blog.user_id = current_user.id
    
    if @blog.save
      NoticeMailer.sendmail_blog(@blog).deliver
      redirect_to blogs_path, notice: "ブログを作成しました！"
    else
      render action: 'new'
    end
  end
  
  def edit
    @blog = Blog.find(params[:id])
  end
  
  def show
  end
  
  def update
    @blog = Blog.find(params[:id])
    
    if @blog.update(blogs_params)
      redirect_to blogs_path, notice: "ブログを更新しました！"
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path, notice: "ブログを削除しました！"
  end
  
  def confirm
    @blog = Blog.new(blogs_params)
    render :new if @blog.invalid?
  end
  
  def show
  end
  
  private
  def blogs_params
    params.require(:blog).permit(:title, :content)
  end
  
  def set_blog
    @blog = Blog.find(params[:id])
  end
end
