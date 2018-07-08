class Advertisement < ApplicationRecord
  include Filterable

  belongs_to :company
  belongs_to :user

  has_many :advertisement_photos

  accepts_nested_attributes_for :advertisement_photos

  scope :title, -> (title) { where("title ILIKE ?", "%#{title}%")}
  scope :body, -> (body) { where("body ILIKE ?", "%#{body}%")}
  scope :ad_type, -> (ad_type) { where("ad_type = ?", ad_type) }
end
