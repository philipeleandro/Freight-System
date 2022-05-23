require 'rails_helper'

describe 'User views orders' do
  it 'in user page' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
    user = User.create(name: 'Philipe', email: 'philipe@impact.com.br', password: '12345678')
    company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
    product = Product.create(depth: 10, height: 20, width: 20, weight: 15, sku: 'ASD231ASDS', address: 'Rua viva, 10')
    order = Order.create(receiver_name: 'Pedro', delivery_address: 'Rua das entregas, 700', company: company, product: product)
 
    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Serviços'

    expect(page).to have_content('Serviços')
    expect(page).to have_content('Status: Pendente')
    expect(page).to have_content('Para: Rua das entregas, 700')
    expect(page).to have_link('Aceitar')
  end

  it 'Only its orders' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
    user = User.create(name: 'Philipe', email: 'philipe@impact.com.br', password: '12345678')
    company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
    company_two = Company.create(corporate_name: 'Imp LTDA', domain: 'imp.com.br', brand_name: 'Imp', address: 'Rua das flores, 1000', cnpj: '12345678974562', freight: 100, threshold: 500, user: admin)
    product = Product.create(depth: 10, height: 20, width: 20, weight: 15, sku: 'ASD231ASDS', address: 'Rua viva, 10')
    product_two = Product.create(depth: 10, height: 20, width: 20, weight: 15, sku: 'ASD231ASSS', address: 'Rua viva, 10')
    order = Order.create(receiver_name: 'Pedro', delivery_address: 'Rua entregas, 700', company: company, product: product, status: 1)
    order_two = Order.create(receiver_name: 'Lucas', delivery_address: 'Rua das entregas, 700', company: company_two, product: product_two)

    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Serviços'

    expect(page).to have_content('Status: Aceito')
    expect(page).to have_content('Para: Rua entregas, 700')
  end

  it 'does not exist registered order' do
    user = User.create(name: 'Philipe', email: 'philipe@impact.com.br', password: '12345678')
 
    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Serviços'

    expect(page).to have_content('Não há ordem de serviço para sua empresa')
  end
end