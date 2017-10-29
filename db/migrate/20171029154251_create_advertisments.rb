class CreateAdvertisments < ActiveRecord::Migration[5.1]
  def change
    create_table :advertisments do |t|
      t.text :body
      t.integer :amount
      t.datetime :delivery_date_from
      t.decimal :price
      t.references :company, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
