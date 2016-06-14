class User < ActiveRecord::Base
  has_many :accounts
  has_many :transactions, through: :account
  has_many :users, through: :users_achievement
  
  has_secure_password
end
