class CommentsController < ApplicationController
  # before_action :set_post
  #before_action only: [:edit, :create, :destroy]

  def index
    @comments = Comment.all.order(created_at: :desc)
    render json: @comments
  end


  def show
    @comments = Comment.find(params[:id])
    render json: @comments
  end


  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params.merge(user: @current_user))
    redirect_to post_path(@post)
  end

  def update_comments
    post = Post.find(comment_params[:post_id])
    comments = comment_params[:comments]
    
    comments.each do |comment|
      post.comments << comment
    end  
    render json: post
  end
  
  def update
    @comment = @post.comments.new(comment_params)
    @comment.user = @current_user
    if @comment.save
      redirect_to @post, notice: 'Comment was successfully added.'
    else
      render :show
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  private

  def comment_params
    params.permit(:comment)
  end

end




