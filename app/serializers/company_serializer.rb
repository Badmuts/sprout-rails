class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :zipcode, :country, :city, :created_at
  
  has_many :user
end
