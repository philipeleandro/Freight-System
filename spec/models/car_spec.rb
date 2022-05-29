require 'rails_helper'

RSpec.describe Car, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'must have plate' do
        admin = User.create(name: 'admin', email: 'admin@sistemasdeentregas.com.br', password: '12345678')
        new_company = Company.create(corporate_name: 'Company LTDA', brand_name: 'Company',
                                     address: 'Rua das flores, 1000', domain: 'company.com.br', cnpj: '12345678911234',
                                     freight: 100, threshold: 500, user: admin)
        car = Car.create(model: 'Truck', brand: 'Volkswagem', plate: '', year: 2010, max_load: 2000,
                         company: new_company)

        expect(car.valid?).to eq false
      end

      it 'must have max load' do
        admin = User.create(name: 'admin', email: 'admin@sistemasdeentregas.com.br', password: '12345678')
        new_company = Company.create(corporate_name: 'Company LTDA', brand_name: 'Company',
                                     address: 'Rua das flores, 1000', domain: 'company.com.br',
                                     cnpj: '12345678911234', freight: 100, threshold: 500, user: admin)
        car = Car.create(model: 'Truck', brand: 'Volkswagem', plate: 'ASC 1345', year: 2010, max_load: '',
                         company: new_company)

        expect(car.valid?).to eq false
      end
    end

    context 'format' do
      it 'false when plate has less than 4 numbers' do
        admin = User.create(name: 'admin', email: 'admin@sistemasdeentregas.com.br', password: '12345678')
        new_company = Company.create(corporate_name: 'Company LTDA', brand_name: 'Company',
                                     address: 'Rua das flores, 1000', domain: 'company.com.br', cnpj: '12345678945236',
                                     freight: 100, threshold: 500, user: admin)
        car = Car.create(model: 'Truck', brand: 'Volkswagem', plate: 'ADC-456', year: 2010, max_load: 2000,
                         company: new_company)

        expect(car.valid?).to eq false
      end

      it 'false when plate has more than 4 numbers' do
        admin = User.create(name: 'admin', email: 'admin@sistemasdeentregas.com.br', password: '12345678')
        new_company = Company.create(corporate_name: 'Company LTDA', brand_name: 'Company',
                                     address: 'Rua das flores, 1000', domain: 'company.com.br', cnpj: '12345678945236',
                                     freight: 100, threshold: 500, user: admin)
        car = Car.new(model: 'Truck', brand: 'Volkswagem', plate: 'ADC-45445', year: 2010, max_load: 2000,
                      company: new_company)

        expect(car.valid?).to eq false
      end

      it 'false when plate is not in correct format' do
        admin = User.create(name: 'admin', email: 'admin@sistemasdeentregas.com.br', password: '12345678')
        new_company = Company.create(corporate_name: 'Company LTDA', brand_name: 'Company',
                                     address: 'Rua das flores, 1000', domain: 'company.com.br', cnpj: '12345678945236',
                                     freight: 100, threshold: 500, user: admin)
        car = Car.new(model: 'Truck', brand: 'Volkswagem', plate: 'AsX-45445', year: 2010, max_load: 2000,
                      company: new_company)
        car_two = Car.new(model: 'Truck', brand: 'Volkswagem', plate: 'AX-45445', year: 2010, max_load: 2000,
                          company: new_company)
        car_three = Car.new(model: 'Truck', brand: 'Volkswagem', plate: 'A6X-45445', year: 2010, max_load: 2000,
                            company: new_company)

        expect(car.valid?).to eq false
        expect(car_two.valid?).to eq false
        expect(car_three.valid?).to eq false
      end
    end

    context 'greater' do
      it 'false when year is less than 2000' do
        admin = User.new(name: 'admin', email: 'admin@sistemasdeentregas.com.br', password: '12345678')
        new_company = Company.create(corporate_name: 'Company LTDA', brand_name: 'Company',
                                     address: 'Rua das flores, 1000', domain: 'company.com.br', cnpj: '12345678911234',
                                     freight: 100, threshold: 500, user: admin)
        car = Car.create(model: 'Truck', brand: 'Volkswagem', plate: 'ADC-4544', year: 1990, max_load: 2000,
                         company: new_company)

        expect(car.valid?).to eq false
      end

      it 'true when year is more than 2000' do
        admin = User.new(name: 'admin', email: 'admin@sistemasdeentregas.com.br', password: '12345678')
        new_company = Company.create(corporate_name: 'Company LTDA', brand_name: 'Company',
                                     address: 'Rua das flores, 1000', domain: 'company.com.br', cnpj: '12345678911234',
                                     freight: 100, threshold: 500, user: admin)
        car = Car.create(model: 'Truck', brand: 'Volkswagem', plate: 'ADC-4544', year: 2001, max_load: 2000,
                         company: new_company)

        expect(car.valid?).to eq true
      end
    end

    context 'uniqueness' do
      it 'false when already exist a plate' do
        admin = User.new(name: 'admin', email: 'admin@sistemasdeentregas.com.br', password: '12345678')
        new_company = Company.create(corporate_name: 'Company LTDA', brand_name: 'Company',
                                     address: 'Rua das flores, 1000', domain: 'company.com.br', cnpj: '12345678911234',
                                     freight: 100, threshold: 500, user: admin)
        Car.create(model: 'Truck', brand: 'Volkswagem', plate: 'ADC-4544', year: 2001, max_load: 2000,
                   company: new_company)
        car_two = Car.create(model: 'Truck', brand: 'Volkswagem', plate: 'ADC-4544', year: 2003, max_load: 2000,
                             company: new_company)

        expect(car_two.valid?).to eq false
      end
    end
  end
end
