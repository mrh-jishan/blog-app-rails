class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  def index
    @posts = @user.posts.paginate(page: params[:page]).order('created_at DESC')
    json_response({current_page: @posts.current_page,
                   per_page: @posts.per_page,
                   total_entries: @posts.total_entries,
                   entries: @posts})
  end

  def create
    @post = @user.posts.create!(post_params)
    json_response(@post, :created)
  end

  def show
    json_response(@post)
  end

  def update
    @post.update(post_params)
    head :no_content
  end

  def destroy
    @post.destroy
    head :no_content
  end

  private

  def post_params
    params.require(:posts).permit(:title, :sub_title, :body)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
