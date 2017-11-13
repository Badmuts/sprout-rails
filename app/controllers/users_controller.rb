class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user, only: [:me, :destroy, :update, :show, :index]
    
    wrap_parameters User, include: [:email, :password]
    
    access all: [:create], user: {except: [:create]}

    def index
        @users = User.all.limit(@limit).offset(@offset).order('id DESC')
        @count = User.count
        render json: @users, adapter: :json, meta: {count: @count, offset: @offset, limit: @limit }, meta_key: "metadata", root: "results"
    end

    def show
        render json: @user, status: :ok
    end

    def create
        @user = User.new(user_params)
        
        if @user.save!
            render json: @user, status: :created
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end

    def update
        if @user.update!(user_params)
            render json: @user, status: :ok
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @user.destroy
        head :no_content
    end

    def me
        @user = current_user
        render json: @user
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_user
            @user = User.find(params[:id])
        end

        def user_params
            params.require(:user).permit(:email, :password, :name, :company)
        end
end
