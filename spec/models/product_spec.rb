require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when does not have a dimensions' do
        product_one = Product.create(depth: "", height: 20, width: 20, weight: 15, sku: 'ASD231ASDS', address: 'Rua viva, 10')
        product_two = Product.create(depth: 10, height: "", width: 20, weight: 15, sku: 'ASD231ADDS', address: 'Rua viva, 10')
        product_three = Product.create(depth: 10, height: 20, width: "", weight: 15, sku: 'ASDW31ASDS', address: 'Rua viva, 10')

        expect(product_one.valid?).to eq false
        expect(product_two.valid?).to eq false
        expect(product_three.valid?).to eq false
      end

      it 'false when weight is empty' do
        product_one = Product.create(depth: 15, height: 20, width: 20, weight: "", sku: 'ASD231ASDS', address: 'Rua viva, 10')
        product_two = Product.create(depth: 10, height: 40, width: 20, weight: "", sku: 'ASD231ADDS', address: 'Rua viva, 10')

        expect(product_one.valid?). to eq false    
        expect(product_two.valid?). to eq false    
      end

      it 'false when SKU is empty' do
        product_one = Product.create(depth: 15, height: 20, width: 20, weight: 10, sku: '', address: 'Rua viva, 10')
        product_two = Product.create(depth: 10, height: 40, width: 20, weight: 5, sku: 'ASD231ADDS', address: 'Rua viva, 10')

        expect(product_one.valid?). to eq false    
        expect(product_two.valid?). to eq true  
      end
    end

    context 'uniqueness' do
      it 'false when SKU already exist' do
        product_one = Product.create(depth: 10, height: 40, width: 20, weight: 5, sku: 'ASD231ADDS', address: 'Rua viva, 10')
        product_two = Product.create(depth: 10, height: 40, width: 20, weight: 5, sku: 'ASD231ADDS', address: 'Rua viva, 10')

        expect(product_one.valid?).to eq true
        expect(product_two.valid?).to eq false
      end
    end

    context 'format' do
      it 'sku must have 10 digits' do
        product_one = Product.create(depth: 15, height: 20, width: 20, weight: 10, sku: 'ASDWED5AS', address: 'Rua viva, 10')
        product_two = Product.create(depth: 10, height: 40, width: 20, weight: 5, sku: '777ASDS456', address: 'Rua na luta, 20')    
        product_three = Product.create(depth: 10, height: 15, width: 70, weight: 5, sku: 'ASD231ADD55', address: 'Rua viva, 30')    

        expect(product_one.valid?).to eq false
        expect(product_two.valid?).to eq true   
        expect(product_three.valid?).to eq false      
      end

      it 'false when sku has symbols' do
        product = Product.create(depth: 15, height: 20, width: 20, weight: 10, sku: 'ASDWED5AS@', address: 'Rua viva, 10')   

        expect(product.valid?).to eq false
      end
    end

    context 'greater than' do
      it 'false when height is less than 0' do
        product_one = Product.create(depth: 15, height: -1, width: 20, weight: 10, sku: '777AFSS456', address: 'Rua viva, 10')
        product_two = Product.create(depth: 10, height: 0, width: 20, weight: 5, sku: '777ASDS456', address: 'Rua na luta, 20')    
        product_three = Product.create(depth: 10, height: 15, width: 70, weight: 5, sku: 'ASD231ADD5', address: 'Rua viva, 30')    

        expect(product_one.valid?).to eq false
        expect(product_two.valid?).to eq false   
        expect(product_three.valid?).to eq true  
      end

      it 'false when weight is less than 0' do
        product_one = Product.create(depth: 15, height: 20, width: 20, weight: -20, sku: 'ASDWED5AS', address: 'Rua viva, 10')
        product_two = Product.create(depth: 10, height: 40, width: 20, weight: 5, sku: '777ASDS456', address: 'Rua na luta, 20')    
        product_three = Product.create(depth: 10, height: 15, width: 70, weight: 0, sku: 'ASD231ADD55', address: 'Rua viva, 30')    

        expect(product_one.valid?).to eq false
        expect(product_two.valid?).to eq true   
        expect(product_three.valid?).to eq false      
      end
    end
  end
end
