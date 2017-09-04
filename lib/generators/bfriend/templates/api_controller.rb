class FriendshipsController < ApplicationController
before_action :set_friendship, only: [:destroy]

def create
  @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
  if @bfriend.save
      render json: @friend, status: :created, location: @friend
  else
      render json: @friend.errors, status: :unprocessable_entity
  end
end

def destroy  
    @friendship.destroy
end

def update
	@friendship = Friendship.find_by(id: params[:id])
	@friendship.update(status: "true")
	  if @friendship.save
	    render json: @friend, status: :updated, location: @friend
	  else
	    render json: @friend.errors, status: :unprocessable_entity
	  end
end

  
def destroy
  @friendship = current_user.friendships.find(params[:id])
  @friendship.destroy
end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_friendship
    @friend = friend.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def friend_params
    params.require(:friend).permit(:user_id)
  end
end


 