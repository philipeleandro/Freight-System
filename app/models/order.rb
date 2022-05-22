class Order < ApplicationRecord
  belongs_to :product
  belongs_to :company
  belongs_to :car, optional: true

  attribute :status, default: 0
  enum status: {  pendent_accept: 0, accepted: 1, refused: 2, finished: 3, in_progress: 4 }

  validates :status, :code, :receiver_name, :delivery_address, presence: true
  before_validation :generate_code

  
  def generate_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end
end
