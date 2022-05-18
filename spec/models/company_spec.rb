require 'rails_helper'

RSpec.describe Company, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'must have an user' do
        company = Company.create(corporate_name: 'Test LTDA', brand_name: 'Test', cnpj: '1234567894567', address: 'Avenida aeroporto, 1000', freight: 100_000, threshold: 100, domain: '@sistemadetransporte.com')

        expect(company.valid?). to eq false
      end

      it 'must have a cnpj' do
        admin = User.create(name:'admin', email:'admin@sistemadeentregas.com.br', password:'12345678')
        company = Company.create(corporate_name: 'Test LTDA', brand_name: 'Test', cnpj: '', address: 'Avenida aeroporto, 1000', freight: 100_000, threshold: 100, domain: '@sistemadetransporte.com', user: admin)

        expect(company.valid?). to eq false
      end

      it 'must have a domain' do
        admin = User.create(name:'admin', email:'admin@sistemadeentregas.com.br', password:'12345678')
        company = Company.create(corporate_name: 'Test LTDA', brand_name: 'Test', cnpj: '1234567894567', address: 'Avenida aeroporto, 1000', freight: 100_000, threshold: 100, domain: '', user: admin)

        expect(company.valid?). to eq false
      end
    end

    context 'format' do
      it 'cnpj must have only numbers' do
        admin = User.create(name:'admin', email:'admin@sistemadeentregas.com.br', password:'12345678')
        company = Company.create(corporate_name: 'Test LTDA', brand_name: 'Test', cnpj: '1234567894567a', address: 'Avenida aeroporto, 1000', freight: 100_000, threshold: 100, domain: 'company.com.br', user: admin)
     

        expect(company.valid?).to eq false
      end

      it 'cnpj must have 14 digits' do
        admin = User.create(name:'admin', email:'admin@sistemadeentregas.com.br', password:'12345678')
        company = Company.create(corporate_name: 'Test LTDA', brand_name: 'Test', cnpj: '1234567894567', address: 'Avenida aeroporto, 1000', freight: 100_000, threshold: 100, domain: 'company.com.br', user: admin)
        company_two = Company.create(corporate_name: 'Test LTDA', brand_name: 'Test', cnpj: '123456789456799', address: 'Avenida aeroporto, 1000', freight: 100_000, threshold: 100, domain: 'company.com.br', user: admin)

        expect(company.valid?).to eq false
        expect(company_two.valid?).to eq false
      end
    end

    context 'uniq' do
      it 'fail when cnpj already exist' do
        admin = User.create(name:'admin', email:'admin@sistemadeentregas.com.br', password:'12345678')
        company = Company.create(corporate_name: 'Test LTDA', brand_name: 'Test', cnpj: '12345678945679', address: 'Avenida aeroporto, 1000', freight: 100_000, threshold: 100, domain: 'company.com.br', user: admin)
        company_two = Company.create(corporate_name: 'Test LTDA', brand_name: 'Test', cnpj: '12345678945679', address: 'Avenida aeroporto, 1000', freight: 100_000, threshold: 100, domain: 'company.com.br', user: admin)

        expect(company_two.valid?).to eq false
      end
    end
  end
end
