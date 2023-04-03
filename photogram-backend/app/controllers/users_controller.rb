class UsersController < ApplicationController
    before_action only: [:edit, :index, :update, :destroy, :following, :followers, :show_current_user]
    #skip_before_action :authorize, only: :create

    def following_count
      user = User.find(params[:id])
      render json: { following_count: user.following_count }
    end

    def index
        users = User.paginate(page: params[:page])
        render json: users, include: (:following)
    end

    # def show_current_user
    #   if session[:user_id]
    #     user = User.find(session[:user_id])
    #     response.set_header('Access-Control-Allow-Credentials', 'true')
    #     render json: user
    #   else
    #     render json: {}, status: :unauthorized
    #   end
    # end
    def logged_user
      if session[:user_id]
        user = User.find(session[:user_id])
        render json: user, status: :ok, include: :posts
      else
        render json: { error: 'User not logged in' }, status: :unauthorized
      end
      response.set_header('Access-Control-Allow-Credentials', 'true')
    end
    
    

    # def show_current_user
    #   user = User.find_by(id: session[:user_id])
    #   if user
    #     render json: user
    #   else
    #     render json: { error: "Not authorized" }, status: :unauthorized
    #   end
    # end

    def show
      @user = User.find(params[:id])
      render json: @user.as_json(methods: :following_count)
    end


    def followers_count
      user = User.find(params[:id])
      render json: { followers_count: user.followers_count }
    end

    #follow another user

    def follow
      @user = User.find(params[:id])
      @current_user.following << @user unless @current_user.following.include?(@user)
      redirect_to @user
    end
        
    def following
       @following = User.find(params[:id]).following
       render json: @following
    end

    def unfollow
      @user = User.find(params[:id])
      @current_user.following.delete(@user) if @current_user.following.include?(@user)
      redirect_to @user
    end

    #list followers
    def followers
      @followers = User.find(params[:id]).followers
      render json: @followers
    end


    #creating user on signup page

    def new
      @user = User.new
    end

   #creating user on signup page
    def create
      user = User.create(user_params)
      if user.valid?
        render json: user, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

  def my_posts
    @posts = @current_user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(users_params)
      redirect_to @user, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  # def loggedin
  #   user = User.find_by(id: session[:user_id] ) 
  #   if(user)
  #      render json: {loggedin: true, user: user}, include: :posts
  #   else
  #      render json: {loggedin: false}
  #   end      
  # end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def search
    if params[:query].present?
      @users = User.where("username LIKE ? OR name LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    else
      @users = User.none
    end
    render json: @users
  end


private
  def users_params
    params.permit(:name, :profile_pic, :background_image, :bio)
  end

  def user_params
    params.permit(:name, :username, :email, :password, :password_confirmation, :bio)
  end


end
