class Product < ApplicationRecord
  has_many :orders

  validates :weight, :width, :height, :depth, :sku, :address, presence: true
  validates :weight, :width, :height, :depth, numericality: { greater_than: 0 }
  validates :sku, format:  { with: /[A-Z0-9]{10}/ }
  validates :sku, length: { is: 10 }

end
