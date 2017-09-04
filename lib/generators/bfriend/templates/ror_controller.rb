class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:destroy]

 def create
	  @friendship = current_user.friendships.build(friend_id: params[:friend_id])
	  if @friendship.save
	    flash[:notice] = "Friend requested."
	    redirect_to :back
	  else
	    flash[:error] = "Friend request didn't work"
	    redirect_to :back
	  end
	end

	def update
	@friendship = Friendship.find_by(id: params[:id])
	@friendship.update(status: "true")
	  if @friendship.save
	    redirect_to root_url, notice: "Friendship confirmed"
	  else
	    redirect_to root_url, notice: "Sorry! Could not confirm friendship!"
	  end
	end

	def destroy
	  @friendship = Friendship.find_by(id: params[:id])
	  @friendship.destroy
	  flash[:notice] = "Ended friendship."
	  redirect_to :back
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




 
