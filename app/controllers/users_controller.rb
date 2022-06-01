class UsersController < ApplicationController

    before_action :authetificate_user!, only: [:edit, :update]

    def index
        return redirect_to root_path
    end 

    def new
        @user = User.new
    end

    def create 
        @user = User.create user_params

        if @user.save 
            if !@user.avatar.attached?
                @user.avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'placeholder-icon.png')), filename: 'default-image.png', content_type: 'image/png')
            end 
            return redirect_to login_path
        end

        render :new
    end

    def edit
        if user_signed_in?
            @user = User.find(current_user.id)
        else
            redirect_to 
        end
    end

    def update
        @user = User.find(current_user.id)
        if @user.update user_params
            redirect_to root_path
        else 
            render :edit
        end


    end


        
    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :avatar)
    end

end
