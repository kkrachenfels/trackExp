class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :account

  def get_type
    return tType ? "Income" : "Expense"
  end

  def get_signed_amount
    return tType ? amount : -amount
  end

  validates :name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :tDate, presence: true
  validates :tType, inclusion: [true, false]
  validates :amount, presence: true
  validates_numericality_of :amount, :greater_than => 0
end
