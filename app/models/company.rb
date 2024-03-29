class Company < ApplicationRecord
    has_many :users, autosave: true, inverse_of: :company
    has_many :advertisements, autosave: true
    has_many :photos, autosave: true
    has_one :subscription
    
    has_attached_file :logo, styles: { small: "x192", thumb: "x192>" }, default_url: ''
    
    validates :name, presence: true
	validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/
end
