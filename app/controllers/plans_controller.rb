class PlansController < ApplicationController
	before_action :authenticate_user
	access user: :all

	def index
		render json: Plan.all
	end

	def create
		@plan = Plan.new(plan_params)
		if @plan.save!
            render  json: @plan,
                    status: :created
        else
            render json: @plan.errors, status: :unprocessable_entity
        end
	end

	private
		def plan_params
			params.require(:plan).permit(:name, :price)
		end
end
