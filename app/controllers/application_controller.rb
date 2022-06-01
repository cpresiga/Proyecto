class ApplicationController < ActionController::Base
    include Pagy::Backend

    helper_method :current_user
    helper_method :user_signed_in?
    helper_method :name_user
    helper_method :return_user

    def current_user
        User.find_by(id: session[:user_id])
    end

    def user_signed_in?
        !current_user.nil?
    end

    def name_user (valor)
        @user = User.find(valor)
        return @user
    end

    def authetificate_user!
        redirect_to login_path unless user_signed_in?
    end

    def return_user
        @user = User.find_by(id: session[:user_id])
        return @user    
    end

    def search_result
        @article = Article.count
    end 
end
