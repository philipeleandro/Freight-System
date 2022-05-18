class Car < ApplicationRecord
  belongs_to :company

  validates :brand, :model, :year, :max_load, :plate, presence: true
end
