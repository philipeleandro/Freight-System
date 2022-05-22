require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'must have a code' do
        admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
        company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
        product = Product.create(depth: 10, height: 20, width: 20, weight: 15, sku: 'ASD231ASDS', address: 'Rua viva, 10')
        order = Order.new(receiver_name: 'Pedro', delivery_address: 'Rua das entregas, 700', company: company, product: product)
        
        expect(order.valid?).to eq true
      end

      it 'must have a delivery_address' do
        admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
        company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
        product = Product.create(depth: 10, height: 20, width: 20, weight: 15, sku: 'ASD231ASDS', address: 'Rua viva, 10')
        order = Order.new(receiver_name: 'Pedro', delivery_address: '', company: company, product: product)
        
        expect(order.valid?).to eq false
      end
    end

    context 'generate code' do
      it 'when create a new order' do
        admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
        company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
        product = Product.create(depth: 10, height: 20, width: 20, weight: 15, sku: 'ASD231ASDS', address: 'Rua viva, 10')
        order = Order.new(receiver_name: 'Pedro', delivery_address: 'Rua das entregas, 700', company: company, product: product)

        order.save!
        result = order.code
        
        expect(result).not_to be_empty
        expect(result.length).to eq 15
      end
    end

    context 'status' do
      it 'must be pendent_accept when created' do
        admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
        company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
        product = Product.create(depth: 10, height: 20, width: 20, weight: 15, sku: 'ASD231ASDS', address: 'Rua viva, 10')
        order = Order.create(receiver_name: 'Pedro', delivery_address: 'Rua das entregas, 700', company: company, product: product)
        
        expect(order.status).to eq('pendent_accept')
      end
    end

    context 'uniqueness' do
      it 'false when code already exist' do
        admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
        company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
        product = Product.create(depth: 10, height: 20, width: 20, weight: 15, sku: 'ASD231ASDS', address: 'Rua viva, 10')
        order_one = Order.create(receiver_name: 'Pedro', delivery_address: 'Rua das entregas, 700', company: company, product: product)
        order_two = Order.new(receiver_name: 'Pedro', delivery_address: 'Rua das entregas, 700', company: company, product: product)

        order_two.save!

        expect(order_two.code).not_to eq order_one.code
      end
    end
  end
end
