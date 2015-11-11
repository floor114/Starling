class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]

  def show
    redirect_to root_path
  end

  def index
    redirect_to root_path
  end

  def new
    redirect_to root_path
  end

  def edit
    @comment = Comment.find(params[:id])
    if @comment.user_id == current_user.id and @comment.created_at > Time.now-12.hours

    else
      redirect_to :back
    end
  end

  def update
    if @comment.user_id == current_user.id
      respond_to do |format|
        if @comment.update(comment_params)
          format.html { redirect_to post_path(@comment.post_id) }
          format.json { render :show, status: :ok, location: @comment }
        else
          format.html { render :edit }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to :back
    end
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { redirect_to @post }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(Comment.find(params[:id]).post_id)
    if @comment.user_id == current_user.id or current_user.id==1
      @comment.destroy

      respond_to do |format|
        format.html { redirect_to @post }
        format.xml  { head :ok }
      end
    else
      redirect_to @post
    end
  end

  private

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:post_id, :user_id, :content)
    end
end
