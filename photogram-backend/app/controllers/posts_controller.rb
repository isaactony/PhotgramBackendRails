class PostsController < ApplicationController
    before_action :set_post, only: [:show, :destroy, :add_comment, :like]

    # GET /posts
    def index
      @posts = Post.includes(:user, comments: :user).all
      render json: @posts.to_json(include: {user: {}, comments: {include: :user } })
    end

    # GET /posts/1

    def like_count
        likes.count
    end

    def show
        @post = Post.find(params[:id])
        render json: @post, include: :comments
    end

    # POST /posts
  def create
    @post = Post.new(post_params)
    @post.user_id = session[:user_id] # assuming you're using session-based authentication
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end



  # DELETE /posts/1
  def destroy
    post = Post.find_by(id: params[:id])
      if post
        post.destroy
        head :no_content
      else
        render json: { error: "Post not found" }, status: :not_found
      end
  end


    # DELETE /posts/1
    def destroy
      @post.destroy
      redirect_to posts_url, notice: 'Post was successfully destroyed.'
    end
    
  
    # POST /posts/1/like
    def like
      @like = @post.likes.new(user: @current_user)
      if @like.save
        redirect_to @post, notice: 'Post was successfully liked.'
      else
        render :show
      end
    end

   
    
    private

    #def set_current_user
        #@current_user = current_user
    #end

    # def set_post
    #   @post = Post.find(params[:id])
    # end

    def post_params
      params.permit(:post_pic, :caption)
    end

   
  end
