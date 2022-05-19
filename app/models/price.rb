class Price < ApplicationRecord
  belongs_to :company

  validates :min_volume, :max_volume, :min_weight, :max_weight, :value, presence: true
  validates :min_volume, :max_volume, :min_weight, :max_weight, :value, numericality: { greater_than: 0 }
end
