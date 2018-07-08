class WebhookController < ApplicationController
  def create
  	payment = Mollie::Payment.get(params[:id])

  	if payment.paid?
  		company = Company.find_by(mollie_customer_id: payment.customer_id)
  		 return head :not_found if company.nil?

  		subscription = Subscription.find_by(company_id: company.id)
  		subscription.status = 'mandate_created'
  		subscription.save!

  		recurring = Mollie::Customer::Subscription.create(
  			customer_id: payment.customer_id,
  			amount: {
  				currency: "EUR",
  				value: subscription.plan.price
  			},
  			times: 12,
  			interval: '1 month',
  			description: "Sprout #{subscription.plan.name}",
  			webhook_url: "https://587584c6.ngrok.io/webhook/recurring"
		)

  		subscription.status = 'subscription_created'
		subscription.mollie_subscription_id = recurring.id
		subscription.save!

  		render json: params, status: :ok
  	end
  end
end
