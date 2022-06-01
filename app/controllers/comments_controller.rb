class CommentsController < ApplicationController

    before_action :authetificate_user!

    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.create comment_params
        @comment.user = current_user.id
        if @comment.save 
            redirect_to article_path(@article)
        end
    end
      
    def user_comment (valor)
        return User.find(valor)
    end

    private 
    def comment_params
        params.require(:comment).permit(:body)
    end

end
