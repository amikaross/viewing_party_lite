class UsersController < ApplicationController
  def new
  end

  def create 
    user = User.new(app_params)
    if user.save
      session[:user_id] = user.id
      redirect_to "/dashboard"
    else 
      flash[:alert] = "Error: #{error_message(user.errors)}"
      redirect_to register_path
    end
  end

  def show 
    if session[:user_id]
      @user = User.find(session[:user_id])
      @viewing_parties = @user.users_parties
    else
      flash[:alert] = "You do not have permission to access that page"
      redirect_to "/"
    end
  end

  def login_form
  end

  def login_user
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to "/dashboard"
    else
      flash[:alert] = "Error: Incorrect credentials"
      render :login_form
    end
  end

  def logout_user
    reset_session
    redirect_to "/"
  end

  private
  def app_params 
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
 
