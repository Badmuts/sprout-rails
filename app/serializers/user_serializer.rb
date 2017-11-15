class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :created_at, :company
  
  belongs_to :company
end
