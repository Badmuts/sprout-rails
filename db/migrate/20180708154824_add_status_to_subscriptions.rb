class AddStatusToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :status, :string
  end
end
