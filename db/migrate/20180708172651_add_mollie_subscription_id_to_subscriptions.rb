class AddMollieSubscriptionIdToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :mollie_subscription_id, :string
  end
end
