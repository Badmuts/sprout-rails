class AddDeletedAtToCompany < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :deleted_at, :timestamp
  end
end
