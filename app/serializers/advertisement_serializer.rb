class AdvertisementSerializer < ActiveModel::Serializer
  attributes :id, :amount, :delivery_date_from, :price, :company, :user, :created_at, :updated_at

  belongs_to :company
  belongs_to :user
end