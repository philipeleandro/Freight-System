require 'rails_helper'

RSpec.describe DeliveryTime, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'must have a max distance' do
        admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
        new_company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact',
                                     address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100,
                                     threshold: 500, user: admin)
        User.create(name: 'Impact', email: 'user@impact.com.br', password: '12345678')
        delivery_time = DeliveryTime.create(min_distance: 0, max_distance: '', days: 5, company: new_company)

        expect(delivery_time.valid?).to eq false
      end

      it 'false when days does not has a value' do
        admin = User.create(name: 'admin', email: 'admin@sistema0deentregas.com.br', password: '12345678')
        new_company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact',
                                     address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100,
                                     threshold: 500, user: admin)
        User.create(name: 'Impact', email: 'user@impact.com.br', password: '12345678')
        delivery_time = DeliveryTime.create(min_distance: 0, max_distance: 20, days: '', company: new_company)

        expect(delivery_time.valid?).to eq false
      end
    end

    context 'greater' do
      it 'min_volue must be greater or equal than 0' do
        admin = User.create(name: 'admin', email: 'admin@sistema0deentregas.com.br', password: '12345678')
        new_company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact',
                                     address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100,
                                     threshold: 500, user: admin)
        User.create(name: 'Impact', email: 'user@impact.com.br', password: '12345678')
        delivery_time = DeliveryTime.create(min_distance: 0, max_distance: 20, days: 2, company: new_company)
        delivery_time_two = DeliveryTime.create(min_distance: 1, max_distance: 20, days: 2, company: new_company)
        delivery_time_three = DeliveryTime.create(min_distance: -1, max_distance: 20, days: 2, company: new_company)

        expect(delivery_time.valid?).to eq true
        expect(delivery_time_two.valid?).to eq true
        expect(delivery_time_three.valid?).to eq false
      end

      it 'false when days is less than 0' do
        admin = User.create(name: 'admin', email: 'admin@sistema0deentregas.com.br', password: '12345678')
        new_company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact',
                                     address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100,
                                     threshold: 500, user: admin)
        User.create(name: 'Impact', email: 'user@impact.com.br', password: '12345678')
        delivery_time = DeliveryTime.create(min_distance: 0, max_distance: 20, days: -1, company: new_company)

        expect(delivery_time.valid?).to eq false
      end

      it 'false when max_distance is less than 0' do
        admin = User.create(name: 'admin', email: 'admin@sistema0deentregas.com.br', password: '12345678')
        new_company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact',
                                     address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100,
                                     threshold: 500, user: admin)
        User.create(name: 'Impact', email: 'user@impact.com.br', password: '12345678')
        delivery_time = DeliveryTime.create(min_distance: 0, max_distance: 0, days: 2, company: new_company)

        expect(delivery_time.valid?).to eq false
      end

      it 'false when max_distance is less than min_distance' do
        admin = User.create(name: 'admin', email: 'admin@sistema0deentregas.com.br', password: '12345678')
        new_company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact',
                                     address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100,
                                     threshold: 500, user: admin)
        User.create(name: 'Impact', email: 'user@impact.com.br', password: '12345678')
        delivery_time = DeliveryTime.create(min_distance: 0, max_distance: -1, days: 2, company: new_company)

        expect(delivery_time.valid?).to eq false
      end
    end
  end
end
