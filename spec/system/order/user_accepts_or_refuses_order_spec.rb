require 'rails_helper'

describe 'User accepts or refurses order' do
  it 'in orders page' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
    user = User.create(name: 'Philipe', email: 'philipe@impact.com.br', password: '12345678')
    company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
    product = Product.create(depth: 10, height: 20, width: 20, weight: 15, sku: 'ASD231ASDS', address: 'Rua viva, 10')
    order = Order.create(receiver_name: 'Pedro', delivery_address: 'Rua das entregas, 700', company: company, product: product)

    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on('Entrar')
    end
    click_on 'Serviços'

    expect(page).to have_link('Aceitar')
    expect(page).to have_link('Recusar')
  end

  it 'user clicks on Aceitar' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
    user = User.create(name: 'Philipe', email: 'philipe@impact.com.br', password: '12345678')
    company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
    product = Product.create(depth: 10, height: 20, width: 20, weight: 15, sku: 'ASD231ASDS', address: 'Rua viva, 10')
    order = Order.create(receiver_name: 'Pedro', delivery_address: 'Rua das entregas, 700', company: company, product: product)

    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on('Entrar')
    end
    click_on 'Serviços'
    click_on 'Aceitar'

    expect(page).to have_content('Finalize a Ordem de Serviço')
    expect(page).to have_field('Carro')
  end

  it 'success' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
    user = User.create(name: 'Philipe', email: 'philipe@impact.com.br', password: '12345678')
    company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
    product = Product.create(depth: 10, height: 20, width: 20, weight: 15, sku: 'ASD231ASDS', address: 'Rua viva, 10')
    order = Order.create(receiver_name: 'Pedro', delivery_address: 'Rua das entregas, 700', company: company, product: product)
    car = Car.create(model: 'Truck', brand: 'Volkswagem', plate: 'ADC-4567', year: 2010, max_load: 2000, company: company)
    
    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on('Entrar')
    end
    click_on 'Serviços'
    click_on 'Aceitar'
    select 'Truck', from: 'Carro'
    click_on 'Finalizar'

    expect(page).to have_content('Serviços')
    expect(page).not_to have_link('Aceitar')
    expect(page).to have_content('Aceito')
  end

  it 'user clicks on Recusar' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
    user = User.create(name: 'Philipe', email: 'philipe@impact.com.br', password: '12345678')
    company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
    product = Product.create(depth: 10, height: 20, width: 20, weight: 15, sku: 'ASD231ASDS', address: 'Rua viva, 10')
    order = Order.create(receiver_name: 'Pedro', delivery_address: 'Rua das entregas, 700', company: company, product: product)
    car = Car.create(model: 'Truck', brand: 'Volkswagem', plate: 'ADC-4567', year: 2010, max_load: 2000, company: company)
    
    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on('Entrar')
    end
    click_on 'Serviços'
    click_on 'Recusar'
  
    expect(page).to have_content('Serviços')
    expect(page).to have_content('Recuso')
    expect(page).to have_content('Finalizar')
  end

  it 'successful refused' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
    user = User.create(name: 'Philipe', email: 'philipe@impact.com.br', password: '12345678')
    company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
    product = Product.create(depth: 10, height: 20, width: 20, weight: 15, sku: 'ASD231ASDS', address: 'Rua viva, 10')
    order = Order.create(receiver_name: 'Pedro', delivery_address: 'Rua das entregas, 700', company: company, product: product)
    car = Car.create(model: 'Truck', brand: 'Volkswagem', plate: 'ADC-4567', year: 2010, max_load: 2000, company: company)
    
    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on('Entrar')
    end
    click_on 'Serviços'
    click_on 'Recusar'
    click_on 'Finalizar'
  
    expect(page).not_to have_link('Recusar')
    expect(page).to have_content('Recusado')
  end
end