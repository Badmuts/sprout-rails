class AddTypeToAdvertisement < ActiveRecord::Migration[5.1]
  def change
    add_column :advertisements, :type, :string
  end
end
