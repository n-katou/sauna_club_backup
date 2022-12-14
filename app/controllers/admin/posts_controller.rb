# frozen_string_literal: true

class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @posts = Post.order("created_at DESC").page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.order("created_at DESC").page(params[:page]).per(5)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to admin_post_path(post.id)
  end

  # キーワード検索
  def posts_search
    @posts = Post.posts_search(params[:keyword]).order("created_at DESC").page(params[:page]).per(10)
    @keyword = params[:keyword]
    render "index"
  end

  # タグ検索
  def tags_search
    @posts = Post.tags_search(params[:keyword]).order("created_at DESC").page(params[:page]).per(10).distinct  # .distinctで重複を解消 タグ検索機能
    @keyword2 = params[:keyword]
    render "index"
  end

  # タグセレクト
  def tags_select
    @posts = Post.tags_select(params[:tag_id]).order("created_at DESC").page(params[:page]).per(10).distinct  # .distinctで重複を解消
    render "index"
  end

  private
    def post_params
      params.require(:post).permit(:post_image, :title, :post_content, tag_ids: [])
    end
end
