require 'rails_helper'

RSpec.describe Company, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'must have an user' do
        company = Company.create(corporate_name: 'Test LTDA', brand_name: 'Test', cnpj: '1234567897894', address: 'Avenida aeroporto, 1000', freight: 100_000, threshold: 100, domain: '@sistemadetransporte.com')

        expect(company.valid?). to eq false
      end
    end
  end
end
