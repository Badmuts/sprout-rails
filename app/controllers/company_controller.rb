class CompanyController < ApplicationController
    before_action :set_company, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user

    access user: :all

    wrap_parameters Company, include: [:name, :address, :zipcode, :city, :country, :logo, :logo_file_name, :company_photos_attributes]

    rescue_from ActiveRecord::RecordNotFound, :with => :not_found 

    def index
        @companies = Company.all.limit(@limit).offset(@offset).order('name ASC')
        @count = Company.count
        render json: @companies, adapter: :json, meta: {count: @count, offset: @offset, limit: @limit }, meta_key: "metadata", root: "results"
    end

    def show
        # @company.full_logo_url = URI.join(request.url, @company.logo.url(:small))
        render json: @company
    end
    
    def create
        if current_user.company.nil?
            current_user.create_company(company_params)
        else
            current_user.company.update_attributes(company_params)
        end
        
        @company = current_user.company

        if current_user.save
            render :show, status: :created
        else
            render json: @company.errors, status: :unprocessable_entity
        end
    end

    def update
        puts "!!!!!"
        puts company_params
        if @company.update!(company_params)
            render json: @company, status: :ok
        else
            render json: @company.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @company.destroy
        head :no_content
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_company
            @company = Company.find(params[:id])
        end

        def company_params
            params[:company_photos_attributes] = params.delete(:company_photos) if params.has_key? :company_photos
            params.require(:company).permit(:name, :address, :zipcode, :city, :country, :logo, :logo_file_name, { company_photos_attributes: [:id, :photo, :photo_file_name] })
        end

        def not_found
            render json: {
                :status => 404,
                :developerMessage => "Company with id #{params[:id]} not found",
                :userMessage => "not found",
                :errorCode => "444444"
            }, status: :not_found
        end
end
