class UsersController < ApplicationController
    # Retrieve @user before these actions
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    # User should be authenticated for these actions
    before_action :authenticate_user, only: [:me, :destroy, :update, :show, :index]
    
    wrap_parameters User, include: [:email, :password, :company]
    
    # Restrict access for specific roles
    access all: [:create], user: {except: [:create]}

    # Shows an list of users with a default limit of 25
    def index
        @users = User.all.limit(@limit).offset(@offset).order('id DESC')
        @count = User.count
        render json: @users, adapter: :json, meta: {count: @count, offset: @offset, limit: @limit }, meta_key: "metadata", root: "results", base_url: request.base_url
    end

    # Shows specific user
    def show
        render json: @user, base_url: request.base_url, status: :ok
    end

    # Creates an new User with given params
    def create
        @user = User.new(user_params)
        
        if @user.save!
            render json: @user, status: :created, base_url: request.base_url
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end

    # Updates found user with given params
    def update
        if !current_user.has_roles?(:admin) && current_user.id != @user.id
            return render status: :bad_request
        end
        if @user.update!(user_params)
            render json: @user, status: :ok, base_url: request.base_url
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end

    # Removes an user
    def destroy
        @user.destroy
        head :no_content
    end

    # Method to retrieve loggedin user
    def me
        @user = current_user
        render json: @user, base_url: request.base_url
    end

    private
        # Sets @user when :id is found
        def set_user
            @user = User.find(params[:id])
        end

        # Allowed params
        def user_params
            params.require(:user).permit(:email, :password, :name, company: [:id, :name, :address, :zipcode, :city, :country])
        end
end
