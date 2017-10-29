class AddDeletedAtToAdvertisments < ActiveRecord::Migration[5.1]
  def change
    add_column :advertisments, :deleted_at, :datetime
  end
end
