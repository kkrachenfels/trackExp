class UsersController < ApplicationController
  skip_before_action :authorized, only: [:index, :new, :create]

  def index
    flash[:error] = "You do not have access to the this page..
      Redirecting you to the welcome page."
    redirect_to '/welcome'
    #@users = User.all
  end

  def show
#    if session[:user_id] != params[:id]
#      if logged_in?
#        redirect_to user_path(current_user.id)
#      else
#        flash[:error] = "You do have access to this page..
#          Redirecting you to the welcome page."
#        redirect_to '/welcome'
#      end
#    else
#      @user = User.find(params[:id])
#      @transactions = @user.transactions.order("tDate desc")
#    end
    @user = current_user
    @transactions = @user.transactions.order("tDate desc")
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

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
