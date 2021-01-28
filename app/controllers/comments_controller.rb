class CommentsController < ApplicationController

  include PrivateGuard
  include SecureTransaction

  before_action :require_user

  def create
    if (@article = find(Article, params[:article_id])).is_a?(Article)
      @comment = Comment.new(comment_params)
      @comment.article = @article
      @comment.user = current_user
      begin
        @comment.save!
        redirect_to article_path(@article)
      rescue ActiveRecord::ActiveRecordError
        redirect_to root_path, notice: SecureTransaction::FAILING_MESSAGE
      end

    end
  end

  def edit
    if (@comment = find(Comment, params[:id])).is_a?(Comment)
      @article = @comment.article
    end
  end

  def update
    if (@article = find(Article, params[:article_id])).is_a?(Article)
      @comment = @article.comments.find(params[:id])
      @comment.update(comment_params)
      redirect_to article_path(@article), notice: 'Comment changed!'
    end

  end

  def destroy
    if (@article = find(Article, params[:article_id])).is_a?(Article)
      if (@comment = find(@article.comments, params[:id])).is_a?(Comment) # @comment = @article.comments.find(params[:id])
        @comment.destroy
        redirect_to article_path(@article)
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :status)
  end
end
