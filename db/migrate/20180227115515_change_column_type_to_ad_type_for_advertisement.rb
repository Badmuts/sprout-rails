class ChangeColumnTypeToAdTypeForAdvertisement < ActiveRecord::Migration[5.1]
  def change
  	rename_column :advertisements, :type, :ad_type
  end
end
