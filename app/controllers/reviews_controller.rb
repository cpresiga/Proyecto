class ReviewsController < ApplicationController

    before_action :authetificate_user!

    def create
        @book = Book.find(params[:book_id])
        @review = @book.reviews.create review_params
        @review.user_id = current_user.id
        if @review.save
            redirect_to book_path(@book)
        end
    end

    private

    def review_params
        params.require(:review).permit(:comment, :starts)
    end

end
