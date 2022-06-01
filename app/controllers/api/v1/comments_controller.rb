class Api::V1::CommentsController < ApplicationController

    skip_before_action :verify_authenticity_token

    def index
        @api_comments = Comment.all
        render json: @api_comment
    end
    
    def create
        @api_article = Article.find params[:article_id]
        @api_comment = @api_article.comments.create comment_params
        @api_comment.user = 1

        if @api_comment.save
            render json: @api_comment, status: :created
        else
            render json: @api_comment.erros, status: :unprocessable_entity
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:body)
    end
end