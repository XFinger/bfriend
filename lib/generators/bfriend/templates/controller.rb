class BfriendsController < ApplicationController

def create
  @bfriend = current_user.bfriends.build(:bfriend_id => params[:bfriend_id])
  if @bfriend.save
    flash[:notice] = "Added friend."
    redirect_to root_url
  else
    flash[:notice] = "Unable to add friend."
    redirect_to root_url
  end
end

def destroy
  @bfriend = current_user.bfriends.find(params[:id])
  @bfriend.destroy
  flash[:notice] = "Removed friendship."
  redirect_to current_user
end

end