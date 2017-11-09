class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update]
    before_action :authenticate_user, only: [:me, :destroy, :update, :show, :index]
    
    wrap_parameters User, include: [:email, :password]
    
    access all: [:create], user: {except: [:create]}

    def index
        @users = User.all.limit(@limit).offset(@offset).order('id DESC')
        @count = User.count
    end

    def show
    end

    def create
        @user = User.new(user_params)
        
        if @user.save!
            render :show, status: :created
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end

    def update
        if @user.update!(user_params)
            render :show, status: :ok
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end

    def destroy
        current_user.destroy
        head :no_content
    end

    def me
        @user = current_user
        render :show
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_user
            @user = User.find(params[:id])
        end

        def user_params
            params.require(:user).permit(:email, :password, :name)
        end
end
