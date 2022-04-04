class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :account

  def get_type
    return tType ? "Income" : "Expense"
  end

  def get_signed_amount
    return tType ? amount : -amount
  end
end
