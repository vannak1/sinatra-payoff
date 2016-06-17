class UserVane < ActiveRecord::Base
  belongs_to :user
  belongs_to :vane
end
