require 'rails_helper'

RSpec.describe Price, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'must have a min volume' do
        admin = User.create(name: 'admin', email: 'admin@sistema0deentregas.com.br', password: '12345678')
        company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
        user = User.create(name: 'Impact', email: 'user@impact.com.br', password: '12345678')
        price = Price.create(min_volume: "", max_volume: 20, min_weight: 10, max_weight: 20, value: 50, company: company)

        expect(price.valid?). to eq false
      end

      it 'must have a value' do
        admin = User.create(name: 'admin', email: 'admin@sistema0deentregas.com.br', password: '12345678')
        company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
        user = User.create(name: 'Impact', email: 'user@impact.com.br', password: '12345678')
        price = Price.create(min_volume: 15, max_volume: 20, min_weight: 10, max_weight: 20, value: "", company: company)

        expect(price.valid?). to eq false
      end
    end

    context 'greater' do
      it 'min_volue must be greater than 0' do
        admin = User.create(name: 'admin', email: 'admin@sistema0deentregas.com.br', password: '12345678')
        company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
        user = User.create(name: 'Impact', email: 'user@impact.com.br', password: '12345678')
        price = Price.create(min_volume: 0, max_volume: 20, min_weight: 10, max_weight: 20, value: 50, company: company)

        expect(price.valid?). to eq false
      end

      it 'value must be greater than 0' do
        admin = User.create(name: 'admin', email: 'admin@sistema0deentregas.com.br', password: '12345678')
        company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
        user = User.create(name: 'Impact', email: 'user@impact.com.br', password: '12345678')
        price = Price.create(min_volume: 15, max_volume: 20, min_weight: 10, max_weight: 20, value: 0, company: company)

        expect(price.valid?). to eq false
      end
    end
  end
end
