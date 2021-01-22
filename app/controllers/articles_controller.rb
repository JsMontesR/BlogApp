class ArticlesController < ApplicationController

  include PrivateGuard

  before_action :require_user

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
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
    @article = current_user.articles.find(params[:id])
  end

  def update
    @article = current_user.articles.find(params[:id])

    if @article.update(article_params)
      redirect_to @article, notice: "Article updated!"
    else
      render :edit
    end

  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to (articles_path)
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :status)
  end
end