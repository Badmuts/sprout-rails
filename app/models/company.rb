class Company < ApplicationRecord
    has_many :users, autosave: true

    validates :name, presence: true
end
