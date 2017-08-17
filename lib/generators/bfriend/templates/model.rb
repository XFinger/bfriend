
class Friendship < ApplicationRecord
  
  belongs_to :user
  belongs_to :bfriend, :class_name => 'User'


end