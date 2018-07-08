class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :zipcode, :country, :city, :logo, :created_at
  
  def logo
    URI.join(instance_options[:base_url], object.logo.url(:thumb)) unless object.logo.url(:thumb).empty?
  end

  has_many :users
  has_many :advertisements
  has_many :photos
end
