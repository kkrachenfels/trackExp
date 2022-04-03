class User < ApplicationRecord
  has_many :accounts
  has_many :transactions

  has_secure_password

end
