class ArticlesController < ApplicationController

  include PrivateGuard
  include SecureTransaction

  before_action :require_user

  def index
    @articles = Article.all
  end

  def show
    @article = find(Article, params[:id]) # Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.create(article_params)
    if @article
      redirect_to @article
    else
      render :new
    end
  end

  def edit
    @article = find(current_user.articles, params[:id]) # current_user.articles.find(params[:id])
  end

  def update
    if (@article = find(current_user.articles, params[:id])).is_a?(Article) # current_user.articles.find(params[:id])
      if @article.update(article_params)
        redirect_to @article, notice: "Article updated!"
      else
        render :edit
      end
    end
  end

  def destroy
    if (@article = find(Article, params[:id])).is_a?(Article) # Article.find(params[:id])
      @article.destroy
      redirect_to (articles_path)
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :status)
  end
end
