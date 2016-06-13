class User < ActiveRecord::Base
  has_many :accounts
  has_many :transactions, through: :account

  has_secure_password
end
