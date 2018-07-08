class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :created_at
  
  belongs_to :company
end
