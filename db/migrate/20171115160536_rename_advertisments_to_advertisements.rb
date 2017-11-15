class RenameAdvertismentsToAdvertisements < ActiveRecord::Migration[5.1]
  def change
    rename_table :advertisments, :advertisements
  end
end
