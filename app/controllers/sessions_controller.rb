class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create, :welcome]

  def new
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to new_user_transaction_path(@user)
    else
      flash[:notice] = "Login is invalid!"
      redirect_to '/login'
    end
  end

  def login
  end

  def welcome
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to '/welcome'
  end

  def page_requires_login
  end
end
