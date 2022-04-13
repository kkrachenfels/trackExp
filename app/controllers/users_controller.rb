class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  before_action :user_authorized
  skip_before_action :user_authorized, only: [:new, :create]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @transactions = @user.transactions.order("tDate desc")
    #if @user.id != current_user.id
    #  redirect_to '/welcome'
    #end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user.valid?
      session[:user_id] = @user.id
      redirect_to '/welcome'
    else
      #flash[:error] = "Error. Please try to create an account again."
      #redirect_to new_user_path
      render :new, status: :unprocessable_entity
    end
  end


  def user_authorized
    #flash[:error] = "You do not have access to this page."
    #if session[:user_id] == nil || session[:user_id] != @user.id
    #  render :new, status: :unprocessable_entity
    #end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
