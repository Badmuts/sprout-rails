class Advertisement < ApplicationRecord
  include Filterable

  belongs_to :company
  belongs_to :user

  scope :starts_with, -> (title) { where("title ILIKE ?", "%#{title}%")}
end
