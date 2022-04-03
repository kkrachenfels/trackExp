class AccountsController < ApplicationController
  before_action :get_user

  def index
    @accounts = @user.accounts
  end

  def show
    @account = @user.accounts.find(params[:id])
  end

  def new
    @account = @user.accounts.build
  end

  def create
    @account = @user.accounts.build(account_params)
    @account[:balance] = 0

    if @account.save
      redirect_to user_accounts_path(@user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @account = @user.accounts.find(params[:id])
  end

  def update
    @account = @user.accounts.find(params[:id])

    if @account.update(account_params)
      redirect_to user_accounts_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @account = @user.accounts.find(params[:id])
    @account.destroy

    redirect_to user_accounts_path(@user), status: :see_other
  end

  private
    def get_user
      @user = User.find(params[:user_id])
    end

    def account_params
      params.require(:account).permit(:accountName, :balance)
    end
end
