class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.references :company, foreign_key: true
      t.references :plan, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
