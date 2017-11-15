class AdvertisementsController < ApplicationController
    before_action :set_advertisement, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user
    access user: :all

    wrap_parameters Advertisement, include: [:body, :amount, :delivery_date_from, :price, :company, :user]

    def index
        @advertisements = Advertisement
            .all
            .limit(@limit)
            .offset(@offset)
            .order('id DESC')
        @count = Advertisement.count
        render  json: @advertisements, 
                adapter: :json, 
                meta: {count: @count, offset: @offset, limit: @limit },
                meta_key: "metadata", root: "results"
    end

    def show
        render json: @advertisement
    end

    def create
        @advertisement = Advertisement.new(advertisement_params)
        @advertisement.user = current_user
        @advertisement.company = current_user.company

        if @advertisement.save!
            render json: @advertisement, status: :created
        else
            render json: @advertisement.errors, status: :unprocessable_entity
        end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_advertisement
            @advertisement = Advertisement.find(params[:id])
        end

        def advertisement_params
            params.require(:advertisement).permit(:body, :amount, :delivery_date_from, :price, :company, :user)
        end
end
