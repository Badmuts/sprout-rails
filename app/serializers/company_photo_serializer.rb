class CompanyPhotoSerializer < ActiveModel::Serializer
  belongs_to :company
  attributes :id, :photo
end
