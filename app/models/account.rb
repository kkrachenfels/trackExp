class Account < ApplicationRecord
  belongs_to :user

  validates :accountName, presence: true, length: { maximum: 50 }
end
