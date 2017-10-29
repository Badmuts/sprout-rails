class AdvertismentsController < ApplicationController
    before_action :set_advertisment, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user
    access user: :all

    wrap_parameters Advertisment, include: [:body, :amount, :delivery_date_from, :price, :company, :user]

    def index
        @advertisments = Advertisment.all.limit(@limit).offset(@offset).order('id DESC')
        @count = Advertisment.count
    end

    def show
    end

    def create
        @advertisment = Advertisment.new(advertisment_params)
        @advertisment.user = current_user
        @advertisment.company = current_user.company

        if @advertisment.save!
            render :show, status: :created
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_advertisment
            @advertisment = Advertisment.find(params[:id])
        end

        def advertisment_params
            params.require(:advertisment).permit(:body, :amount, :delivery_date_from, :price, :company, :user)
        end
end
