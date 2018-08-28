class SubscriptionSerializer < ActiveModel::Serializer
  attributes :id, :deleted_at
  has_one :company
  has_one :plan
end
