class FriendingsController < ApplicationController

  before_action :require_login, only: [:create, :destroy]

  def create
    friending_recipient = User.find(params[:id])
    if current_user.friendeds << friending_recipient
      flash[:success] = "Successfully friended #{friending_recipient.name}"
      redirect_to friending_recipient
    else
      flash[:danger] = "Failed to friend!"
      redirect_to friending_recipient
    end
  end

  def destroy
    unfriended_user = User.find(params[:id])
    if current_user.friendeds.delete(unfriended_user)
      flash[:success] = "Successfully unfriended"
      redirect_to current_user
    else
      flash[:danger] = "Failed to unfriend"
      redirect_to current_user
    end
  end

  def show
    @user = User.find(params[:id])
    @friendeds = @user.friendeds
    @profile = @user.profile
  end
end