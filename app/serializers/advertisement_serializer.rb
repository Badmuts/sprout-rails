class AdvertisementSerializer < ActiveModel::Serializer
  belongs_to :company
  has_many :advertisement_photos
  
  attributes :id, :title, :body, :ad_type, :amount, :delivery_date_from, :price, :created_at, :updated_at, :company_id
end
