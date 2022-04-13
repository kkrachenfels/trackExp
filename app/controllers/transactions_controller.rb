class TransactionsController < ApplicationController
  before_action :get_user

  def index
    if params[:fromDate] && params[:toDate]
      startD = params[:fromDate]
      endD = params[:toDate]
      @fromD = Date.new startD["(1i)"].to_i, startD["(2i)"].to_i, startD["(3i)"].to_i
      @toD = Date.new endD["(1i)"].to_i, endD["(2i)"].to_i, endD["(3i)"].to_i

      #@transactions = @user.transactions.where(:tDate=>10.days.ago...Time.now)
      @transactions = @user.transactions.where(:tDate=>@fromD..@toD).order("tDate desc")

      #clear params for use again
      params[:fromDate] = nil
      params[:toDate] = nil
    else
      @transactions = @user.transactions.order("tDate desc") #order by transaction date
    end
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
      account = @user.accounts.find(@transaction.account_id)
      account[:balance] += @transaction.get_signed_amount

      if account.save
        redirect_to user_path(@user)
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

    prev_account = @user.accounts.find(@transaction.account_id)
    prev_amount = @transaction.get_signed_amount

    if @transaction.update(transaction_params)
      prev_account[:balance] -= prev_amount

      new_account = @user.accounts.find(@transaction.account_id)
      if new_account.id == prev_account.id
        new_account[:balance] = prev_account[:balance]
      end

      new_account[:balance] += @transaction.get_signed_amount

      if (prev_account.save && new_account.save)
        redirect_to user_transactions_path(@user)
      else
        render :edit, status: :unprocessable_entity
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @transaction = @user.transactions.find(params[:id])

    account = @user.accounts.find(@transaction.account_id)
    account[:balance] -= @transaction.get_signed_amount

    if account.save
      @transaction.destroy
      redirect_to user_transactions_path(@user), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end


  private
    def get_user
      @user = User.find(params[:user_id])
    end

    def transaction_params
      params.require(:transaction).permit(:name, :tType, :tDate, :amount, :account_id, :user_id)
    end
end
