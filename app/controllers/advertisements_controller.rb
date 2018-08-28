class AdvertisementsController < ApplicationController
    before_action :set_advertisement, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user
    access user: :all

    wrap_parameters :advertisement, include: [:title, :body, :ad_type, :amount, :delivery_date_from, :price, :company, :user, :advertisement_photos_attributes]

    def index
        @advertisements = Advertisement
            .all
            .includes(:company)
            .limit(@limit)
            .offset(@offset)
            .filter(advertisement_filter)
            .order('created_at DESC')
        @count = Advertisement.all.filter(advertisement_filter).count
        render  json: @advertisements, 
                base_url: request.base_url,
                adapter: :json, 
                meta: {count: @count, offset: @offset, limit: @limit },
                meta_key: "metadata", root: "results"
    end

    def show
        render json: @advertisement, base_url: request.base_url
    end

    def create
        @advertisement = Advertisement.new(advertisement_params)
        @advertisement.user = current_user
        @advertisement.company = current_user.company

        if @advertisement.save!
            render  json: @advertisement, 
                    base_url: request.base_url,
                    status: :created
        else
            render json: @advertisement.errors, status: :unprocessable_entity
        end
    end

    def update
        if @advertisement.user.company == current_user.company
            @advertisement.update! advertisement_params
            render  json: @advertisement,
                    base_url: request.base_url
        else
            head :forbidden
        end
    end

    def destroy
        if @advertisement.company == current_user.company
            @advertisement.destroy!
            head :no_content
        else
            head :forbidden
        end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_advertisement
            @advertisement = Advertisement.find params[:id]
        end

        def advertisement_params
            params.require(:advertisement).permit(:title, :body, :ad_type, :amount, :delivery_date_from, :price, :company, :user, 
                :advertisement_photos_attributes => [:photo, :photo_file_name]
            )
        end

        def advertisement_filter
            params.slice(:title, :body, :ad_type)
        end
end
