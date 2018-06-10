class PhotosController < ApplicationController
	before_action :set_company, only: [:show, :edit, :update, :destroy, :index]
    before_action :authenticate_user

    access user: :all

	def index
		render json: @company.photos
	end

	def create
		head :no_content
	end

	private
        # Use callbacks to share common setup or constraints between actions.
        def set_company
            @company = Company.find(params[:company_id])
        end
end
