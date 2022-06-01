class ArticlesController < ApplicationController

  before_action :authetificate_user!, only: [:new, :create]

  def index
    @articles_count = Article.count
    @pagy, @articles = pagy(Article.order(created_at: :desc), items: 5)
  end

  def show
    @article = Article.find params[:id]
    @pagy, @article_comment = pagy(@article.comments.order(created_at: :desc), items: 5)
  end

  def new
    @article = Article.new  
  end

  def create
    @article = Article.new article_params
    @article.user_id = current_user.id
    if @article.save
      if !@article.logo.attached?
        @article.logo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'defauld-icon-article.png')), filename: 'default-image-article.png', content_type: 'image/jpg ')
      end 
      redirect_to @article
    else
      render :new
    end
  end

  def edit
    @article = Article.find params[:id]
  end

  def update
    @article = Article.find params[:id]

    if @article.update article_params
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find params[:id]
    
    if @article.destroy
      redirect_to root_path
    else
      redirect_to @article
    end 
  end

  def search
    @query = query_search
    @query_count = @query.count
    @pagy, @articles = pagy(@query, items: 5)
  end

  def like
    @article = Article.find params[:id]
    @article.like = current_user.id
    @article.save
    redirect_to @article
  end

  private 
  
  def article_params
    params.require(:article).permit(:title, :body, :description, :logo, :category, :banner)
  end

  def query_search
    Article.where("title LIKE ?", "%" + params[:q]+ "%")
  end
end
