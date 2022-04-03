class TransactionsController < ApplicationController
  before_action :get_user

  def index
    @transactions = @user.transactions.order("tDate desc") #order by transaction date
  end

  def show
    @transaction = @user.transactions.find(params[:id])
  end

  def new
    @transaction = @user.transactions.build
  end

  def create
    @transaction = @user.transactions.build(transaction_params)

    if @transaction.save
      @account = @user.accounts.find(@transaction.account_id)
      if @transaction.tType
        @account[:balance] += @transaction.amount
      else
        @account[:balance] -= @transaction.amount
      end
      if @account.save
        redirect_to user_transactions_path(@user)
      else
        render :new, status: :unprocessable_entity
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @transaction = @user.transactions.find(params[:id])
  end

  def update
    @transaction = @user.transactions.find(params[:id])

    if @transaction.update(transaction_params)
      redirect_to user_transactions_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @transaction = @user.transactions.find(params[:id])
    @transaction.destroy

    redirect_to user_transactions_path(@user), status: :see_other
  end

  private
    def get_user
      @user = User.find(params[:user_id])
    end

    def transaction_params
      params.require(:transaction).permit(:name, :tType, :tDate, :amount, :account_id, :user_id)
    end
end
