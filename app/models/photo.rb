class Photo < ApplicationRecord
  self.table_name = "company_photos"
  belongs_to :company
  
  has_attached_file :photo, styles: { small: "x800" }
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/
end
