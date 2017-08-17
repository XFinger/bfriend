class FriendshipController < ApplicationController
before_action :set_friendship, only: [:destroy]

def create
  @friendship = current_user.friends.build(:friend_id => params[:friend_id])
  if @bfriend.save
      render json: @friend, status: :created, location: @friend
  else
      render json: @friend.errors, status: :unprocessable_entity
  end
end

def destroy
  @friend = current_user.friend.find(params[:id])
  @friend.destroy
  flash[:notice] = "Removed friendship."
  redirect_to current_user
end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wishlist
      @friend = friend.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def friend_params
      params.require(:friend).permit(:user_id)
    end
end