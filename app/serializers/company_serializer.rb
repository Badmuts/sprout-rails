class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :zipcode, :country, :city, :logo, :created_at
  
  def logo
  	object.logo.url(:small)
  end

  has_many :users
  has_many :advertisements
  has_many :photos
end
