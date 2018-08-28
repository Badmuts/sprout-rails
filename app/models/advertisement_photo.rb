class AdvertisementPhoto < ApplicationRecord
    belongs_to :advertisement

    validates :photo, presence: true 
    has_attached_file :photo, styles: { small: "x800" }
    validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/
end
