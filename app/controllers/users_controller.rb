class UsersController < ApplicationController

  def feeds
    @user = current_user
    @followers = @user.followers(User)
    followees_ids = @user.followees(User).map(&:id)
    @posts = Post.where(:user_id => followees_ids)
  end

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def follow
    @user = User.find(params[:id])
    current_user.follow!(@user)
    redirect_to :back
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.unfollow!(@user)
    redirect_to :back
  end

end
