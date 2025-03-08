# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = current_user.posts.order(id: :desc)
  end

  def show; end

  def new
    @post = current_user.posts.new
  end

  def edit; end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to root_path, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to root_path, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path, notice: 'Post was successfully destroyed.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end
end
