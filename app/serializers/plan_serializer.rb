class PlanSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :deleted_at, :created_at, :updated_at
end
