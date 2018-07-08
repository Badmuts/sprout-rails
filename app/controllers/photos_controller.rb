class PhotosController < ApplicationController
	before_action :set_company, only: [:show, :edit, :update, :destroy, :index]
	before_action :authenticate_user
	before_action :set_photo, only: [:show, :destroy]

    access user: :all

	wrap_parameters Photo

	def index
		render json: @company.photos, base_url: request.base_url
	end

	def create
		@photo = Photo.new(photo_params)
		if @photo.save!
			render json: @photo.company, base_url: request.base_url, status: :created
		else
            render json: @photo.errors, status: :unprocessable_entity
        end
	end

	def destroy
		@photo.destroy
		head :no_content
	end

	private
        # Use callbacks to share common setup or constraints between actions.
		def set_company
			@company = Company.find(params[:company_id])
		end

		def set_photo
			@photo = Photo.find(params[:id])
		end
		
		def photo_params
			params.permit(:photo, :photo_file_name, :company_id)
		end
end
