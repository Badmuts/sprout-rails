class Company < ApplicationRecord
    has_many :users, autosave: true
    has_many :advertisements, autosave: true

    validates :name, presence: true
end
