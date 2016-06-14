class Achievement < ActiveRecord::Base
  has_many :users, through: :users_achievement
end
