class Company < ApplicationRecord
    has_many :users, autosave: true
    has_many :advertisments, autosave: true

    validates :name, presence: true
end
