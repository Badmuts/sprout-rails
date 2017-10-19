class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :address
      t.string :zipcode
      t.string :country

      t.timestamps
    end
  end
end
