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

  validates :username, presence: true, length: { in: 2..20 }, uniqueness: true
  validates :password, presence: true, length: { in: 3..20 }
end
