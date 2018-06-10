class AddDeletedAtColumnToCompanyPhotos < ActiveRecord::Migration[5.1]
  def change
    add_column :company_photos, :deleted_at, :datetime
  end
end
