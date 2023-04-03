class SessionsController < ApplicationController
  #skip_before_action :authorize, only: :create

  
  #   def new
  #   end

  # #signup
  def create
    user = User.find_by(username: user_params[:username])
    if user&.authenticate(user_params[:password])
      session[:user_id] = user.id
      render json: user, status: :created
    else
      render json: { error: "Invalid username or password" }, status: :unauthorized
    end
  end
  
   
  def new
  end

  # def logged_in
  #   user = User.find_by(id: session[:user_id])
  #   if user
  #     render json: user
  #   else 
  #     render json: {message: "user not logged in"}
  #   end
  # end

  def logged_in
    current_user = User.find_by(id: session[:user_id] ) 
    if(current_user)
       render json: [current_user], include: :posts
    else
       render json: {loggedin: false}
    end      
  end

  
  def logout
    session.delete :user_id
    render json: {message: 'Logged out successfully!'}
  end
  
  # def destroy
  #   session[:user_id] = nil
  #   redirect_to root_path, notice: 'Logged out successfully!'
  # end

  private
  
  def user_params
    params.permit(:username, :password)
  end

end

