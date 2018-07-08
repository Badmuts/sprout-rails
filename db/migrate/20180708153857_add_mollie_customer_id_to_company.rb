class AddMollieCustomerIdToCompany < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :mollie_customer_id, :string
  end
end
