
module Bfriend
    def self.included(base)
        base.class_eval do 
            has_many :friendships
            has_many :bfriended_friendships, class_name: "Friendship", foreign_key: "friend_id"
            # bfriended by user
            has_many :current_friends,       -> { where(friendships: { status: true}) }, through: :friendships, source: :friend
            # bfriended by friend
            has_many :bfriended_friends,     -> { where(friendships: { status: true}) }, through: :bfriended_friendships, source: :user                # requested by friend
            has_many :requested_friends,     -> { where(friendships: { status: false}) }, through: :bfriended_friendships, source: :user 
            # requested by user
            has_many :pending_friends,       -> { where(friendships: { status: false}) }, through: :friendships, source: :friend
        end
        # combine the sets to see all your friends
        def friends
            current_friends | bfriended_friends
        end
        # combine the sets to see pending and requested friendships
        def pending
            pending_friends | requested_friends
        end 
    end
end
