class Advertisement < ApplicationRecord
  include Filterable

  belongs_to :company
  belongs_to :user

  scope :title, -> (title) { where("title ILIKE ?", "%#{title}%")}
  scope :body, -> (body) { where("body ILIKE ?", "%#{body}%")}
end
