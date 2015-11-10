class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    redirect_to root_path
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @likeable = @post
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    if @post.user_id == current_user.id and @post.created_at > Time.now-1.day

    else
      redirect_to :back
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to user_path(current_user), notice: ['success', 'Post was successfully created.'] }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if @post.user_id == current_user.id
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
    else
      redirect_to :back
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    if @post.user_id == current_user.id
      @post.destroy
      respond_to do |format|
        format.html { redirect_to user_path(current_user),notice: ['error', 'Post was successfully destroyed.']  }
        format.json { head :no_content }
      end
    else
      redirect_to :back
    end
  end

  def vote
    @user = current_user
    @post = Post.find params[:id]
    @kek = @post.likers_count
    if request.post?
      @user.like!(@post)
      @kek+=1
    elsif request.delete?
      @user.unlike!(@post)
      @kek-=1
    end
    respond_to do |format|
      format.js #-> only XHR allowed
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:user_id, :content)
    end
end
