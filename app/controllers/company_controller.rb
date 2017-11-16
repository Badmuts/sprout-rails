class CompanyController < ApplicationController
    before_action :set_company, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user

    access user: :all

    wrap_parameters Company, include: [:name, :address, :zipcode, :city, :country]

    def index
        @companies = Company.all.limit(@limit).offset(@offset).order('id DESC')
        @count = Company.count
        render json: @companies, adapter: :json, meta: {count: @count, offset: @offset, limit: @limit }, meta_key: "metadata", root: "results"
    end

    def show
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
        if @company.update!(company_params)
            render :show, status: :ok
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
            params.require(:company).permit(:name, :address, :zipcode, :city, :country)
        end
end
