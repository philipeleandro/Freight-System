require 'rails_helper'

RSpec.describe Car, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'must have plate' do
        admin = User.create(name:'admin', email:'admin@sistemasdeentregas.com.br', password:'12345678')
        company = Company.create(corporate_name: 'Company LTDA', brand_name: 'Company', address: 'Rua das flores, 1000', cnpj: '1234567890', freight: 100, threshold: 500, user: admin)
        car = Car.create(model: 'Truck', brand: 'Volkswagem', plate: '', year: 2010, max_load: 2000, company: company)

        expect(car.valid?).to eq false
      end

      it 'must have max load' do
        admin = User.create(name:'admin', email:'admin@sistemasdeentregas.com.br', password:'12345678')
        company = Company.create(corporate_name: 'Company LTDA', brand_name: 'Company', address: 'Rua das flores, 1000', cnpj: '1234567890', freight: 100, threshold: 500, user: admin)
        car = Car.create(model: 'Truck', brand: 'Volkswagem', plate: 'ASC 1345', year: 2010, max_load: '', company: company)

        expect(car.valid?).to eq false
      end
    end
  end
end
