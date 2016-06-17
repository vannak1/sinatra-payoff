class User < ActiveRecord::Base
  has_many :accounts
  has_many :transactions, through: :account
  has_many :vanes, through: :user_vanes
  has_many :user_vanes

  has_secure_password
end
