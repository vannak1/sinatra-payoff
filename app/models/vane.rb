class Vane < ActiveRecord::Base
  has_many :users, through: :user_vanes
  has_many :user_vanes
end
