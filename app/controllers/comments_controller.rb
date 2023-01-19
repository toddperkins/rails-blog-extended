class CommentsController < ApplicationController

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)

    if @comment.save
      redirect_to article_path(@article)
    else
      if @comment.errors.any?
        session[:comment_errors] = @comment.errors
      end
      redirect_to article_path(@article)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to article_comment_path, status: :see_other
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

end
