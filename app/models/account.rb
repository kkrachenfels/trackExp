class Account < ApplicationRecord
  belongs_to :user
  has_many(
    :transactions,
    dependent: :destroy
  )

  validates :accountName, presence: true, length: { minimum: 2, maximum: 50 }
end
