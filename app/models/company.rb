class Company < ApplicationRecord
  belongs_to :user
  has_many :cars

  validates :corporate_name, :brand_name, :cnpj, :address, :freight, :threshold, :domain, presence: true
  validates :cnpj, uniqueness: true
  validates :cnpj, format: { with: /[0-9]{14}/ }
  validates :cnpj, length: { is: 14 }
end
