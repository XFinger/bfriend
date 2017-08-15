class Bfriends < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :bfriend, :class_name => 'User'


end