class UsersController < ApplicationController

  def feeds
    @user = current_user
    @followers = @user.followers(User)
    followees_ids = @user.followees(User).map(&:id)
    @posts = Post.where(:user_id => followees_ids).paginate(:page => params[:page], :per_page => 15).order(:created_at).reverse_order
  end

  def index
    @users = User.all.paginate(:page => params[:page], :per_page => 15).order(:created_at).reverse_order

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(:page => params[:page], :per_page => 15).order(:created_at).reverse_order
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
