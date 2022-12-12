class UsersController < ApplicationController
  def new
  end

  def create 
    user = User.new(app_params)
    if user.save
      redirect_to user_path(user)
    else 
      flash[:alert] = "Error: #{error_message(user.errors)}"
      redirect_to register_path
    end
  end

  def show 
    @user = User.find(params[:id])
    @viewing_parties = @user.users_parties
  end

  def login_form
  end

  def login_user
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash[:alert] = "Error: Incorrect credentials"
      render :login_form
    end
  end

  private
  def app_params 
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
 
