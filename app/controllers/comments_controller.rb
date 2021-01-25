class CommentsController < ApplicationController

  include PrivateGuard

  before_action :require_user

  def create
    @article = Article.find(params[:article_id])
    @comment = Comment.create(comment_params)
    @comment.article = @article
    @comment.user = current_user
    @comment.save!
    redirect_to article_path(@article)
  end

  def edit
    @comment = Comment.find(params[:id])
    @article = @comment.article
  end

  def update
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.update(comment_params)
    redirect_to article_path(@article), notice: 'Comment changed!'
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :status)
  end
end
