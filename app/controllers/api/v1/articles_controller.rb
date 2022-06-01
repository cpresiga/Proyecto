class Api::V1::ArticlesController < ApplicationController

    skip_before_action :verify_authenticity_token
    add before_action :authenticate_user!

    def index 
        @api_article = Article.all
        render json: @api_article   
    end 

    def create
        @api_article = Article.new(article_params)
        if @api_article.save
            render json: @api_article, status: :created
        else
            render json: @api_article.errors, stautus: :unprocessable_entity
        end
    end

    def update
        @api_article = Article.find params[:id]
        if @api_article.update article_params
            render json: @api_article, status: :ok
        else
            render json: @api_article.errors, status: :unprocessable_entity
        end 
    end

    private

    def article_params
        params.require(:article).permit(:title, :body, :description, :category)
    end 
    
end 