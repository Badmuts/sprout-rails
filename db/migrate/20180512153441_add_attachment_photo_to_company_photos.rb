class AddAttachmentPhotoToCompanyPhotos < ActiveRecord::Migration[5.1]
  def self.up
    change_table :company_photos do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :company_photos, :photo
  end
end
