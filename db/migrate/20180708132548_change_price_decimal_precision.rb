class ChangePriceDecimalPrecision < ActiveRecord::Migration[5.1]
  def change
  	change_column :plans, :price, :decimal, :precision => 15, :scale => 2
  end
end
