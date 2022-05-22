class Car < ApplicationRecord
  has_one :order
  belongs_to :company
  
  validates :brand, :model, :year, :max_load, :plate, presence: true
  validates :year, numericality: { greater_than: 2000 }
  validates :plate, format: { with: /[A-Z]{3}-[0-9]{4}/ }
  validates :plate, length: { is: 8 }
  validates :plate, uniqueness: true
end
