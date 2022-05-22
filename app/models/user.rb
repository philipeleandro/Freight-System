class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true

  attribute :kind, default: :set_role
  after_create :set_role
   
  def set_role
    set_user = User.last
    if set_user.email.split("@").last == "sistemadeentregas.com.br"
      set_user.kind = "Admin"
      set_user.save
    else 
      set_user.kind = "Regular"
      set_user.save
    end
  end
end
