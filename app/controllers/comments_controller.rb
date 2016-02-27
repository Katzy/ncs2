class CommentsController < ApplicationController


  def index

    @comments = Comment.all
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @comment = Comment.new
    @comments = Comment.order('created_at ASC')
  end



  def create

    @comment = current_user.comments.build(comment_params)

    @comment.save
  end


  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end

end