class DeliveryTime < ApplicationRecord
  belongs_to :company

  validates :min_distance, :max_distance, :days, presence: true
  validates :max_distance, :days, numericality: { greater_than: 0 }
  validates :min_distance, numericality: { greater_than_or_equal_to: 0 }
  validates :max_distance, numericality: { greater_than: :min_distance }
end
