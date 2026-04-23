class CommentsController < ApplicationController
  # Information needed to create comments
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  # Information for comments to save
  private
  def comment_params
    params.require(:comment).permit(:commented, :body)
  end
end
