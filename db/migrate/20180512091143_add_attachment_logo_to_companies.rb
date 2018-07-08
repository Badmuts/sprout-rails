class AddAttachmentLogoToCompanies < ActiveRecord::Migration[5.1]
  def self.up
    change_table :companies do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :companies, :logo
  end
end
