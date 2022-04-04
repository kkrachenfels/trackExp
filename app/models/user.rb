class User < ApplicationRecord
  has_many :accounts
  has_many :transactions

  has_secure_password

  def get_balance
    total_balance = 0
    accounts.each do |account|
      total_balance += account.balance
    end
    return total_balance
  end
end
