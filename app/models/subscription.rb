class Subscription < ApplicationRecord
  belongs_to :company
  belongs_to :plan
end
