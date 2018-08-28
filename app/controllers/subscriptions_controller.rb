class SubscriptionsController < ApplicationController
	before_action :authenticate_user
	access user: :all

	def index
		subscriptions = Subscription.all.where company_id: current_user.company.id
		render json: subscriptions, base_url: request.base_url
	end

	def create
		if current_user.company.subscription.nil?
			@subscription = Subscription.new(subscription_params)
			@subscription.company = current_user.company
		else
			@subscription = current_user.company.subscription
			@subscription.plan_id = params[:plan_id]
		end

		if @subscription.plan.price <= 0
			@subscription.status = "paid"
			@subscription.save!
			return render json: @subscription, status: :created, base_url: request.base_url
		end
		
		@subscription.status = "pending"

		if @subscription.save
			# Create a mollie customer
			if current_user.company.mollie_customer_id.nil?
				customer = Mollie::Customer.create(
					name: current_user.company.name,
					email: current_user.email
				)

				current_user.company.mollie_customer_id = customer.id
				current_user.company.save!
			end

			# Setup first payment for recurring
			payment = Mollie::Payment.create(
				amount: { value: '0.01', currency: 'EUR' },
				customer_id: current_user.company.mollie_customer_id,
				sequence_type: "first",
				description: "Sprout premium",
				redirect_url: params[:redirect_url],
				webhook_url: "#{Rails.configuration.webhook_base_url}/webhook"
			)

			render 	json: { :checkout_url => payment.checkout_url }, 
					status: :created
			# https://587584c6.ngrok.io
		else
			render json: @subscription.errors, status: :unprocessable_entity
		end
	end

	def destroy
		subscription = Subscription.find params[:id]
		if subscription.company == current_user.company
			subscription.destroy!
			head :no_content
		else
			head :not_found
		end
	end

	private
		def subscription_params
			params.require(:subscription).permit(:plan_id)
		end
end
