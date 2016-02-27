class CommentsController < ApplicationController


  def index
    @comment = Comment.new
    @comments = Comment.order('created_at DESC')
  end

  def new
    @comment = Comment.new
    @comments = Comment.order('created_at ASC')
  end



  def create
    if current_user
      @comment = current_user.comments.build(comment_params)
      if @comment.save
        flash[:success] = 'Your comment was successfully posted!'
      else
        flash[:error] = 'Your comment cannot be shared.'
      end
      format.html {redirect_to 'index'}
      format.js
    else
      format.html {redirect_to 'index'}
      format.js {render nothing: true}
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end