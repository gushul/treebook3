class UserFriendshipsController < ApplicationController
  #before_filter :authenticate_user!

  def index
    @user_friendships = current_user.user_friendships.all
  end

  def accept
    @user_friendship = current_user.user_friendships.find(params[:id])
    if @user_friendship.accept!
      flash[:success] = "You are now friends with #{@user_friendship.friend.first_name}"
    else
      flash[:error] = "That friendship could not be accepted"
    end
      redirect_to user_friendships_path
  end

  def edit
    @user_friendship = current_user.user_friendships.find(params[:id])
  end

  def destroy
    @user_friendship = current_user.user_friendships.find(params[:id])
    @user_friendship.delete
    redirect_to root_path
  end

  def new
    #@friend = User.last
    #@user_friendship = current_user.user_friendships.new(friend: @friend)
  	if params[:friend_id]
  		@friend = User.find(params[:friend_id])
      #@friend = User.where(profile_name: params[:user_friendship][:friend_id]).first
  		#@user_friendship = current_user.user_friendships.new(friend: @friend)
      @user_friendship = UserFriendship.request(current_user, @friend)

      if @user_friendship.new_record?
        flash[:error] = "There was a problem with your request"
      else
        flash[:success] = "Friend request sent"
      end
        redirect_to profile_path(@friend.profile_name)

  	else
  		flash[:error] = "Friend required"
      redirect_to root_path
	end 

	rescue ActiveRecord::RecordNotFound
		render file: 'public/404', status: :not_found
	end

  def create
    if params[:user_friendship] && params[:user_friendship].has_key?(:friend_id)
      @friend = User.where(profile_name: params[:user_friendship][:friend_id]).first
      #@friend = User.find(params[:friend_id])
      #@user_friendship = current_user.user_friendships.new(friend: @friend)
      @user_friendship = UserFriendship.request(current_user, @friend)
      if @user_friendship.new_record?
        flash[:error] = "There was a problem with your request"
       else
        flash[:success] = "Friend request sent"
      end
        redirect_to profile_path(@friend.profile_name)

    else
      flash[:error] = "Friend required"
      redirect_to root_path
    end 
  end
	
end
