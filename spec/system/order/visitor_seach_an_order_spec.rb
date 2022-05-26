require 'rails_helper'

describe 'Visitor searches an order' do
  it 'in root_path' do
    visit root_path

    expect(page).to have_field('Buscar Pedido')
    expect(page).to have_button('Buscar')
  end

  it 'success' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
    user = User.create(name: 'Philipe', email: 'philipe@impact.com.br', password: '12345678')
    company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
    product = Product.create(depth: 10, height: 20, width: 20, weight: 15, sku: 'ASD231ASDS', address: 'Rua viva, 10')
    order = Order.create(receiver_name: 'Pedro', delivery_address: 'Rua das entregas, 700', company: company, product: product, position: 'Galpão de Minas', date: Date.today , time: Time.now )

    visit root_path
    fill_in 'Buscar Pedido', with: order.code
    click_on 'Buscar'

    expect(page).to have_content("Resultado da busca por: #{order.code}")
    expect(page).to have_content('Origem: Rua viva, 10')
    expect(page).to have_content('Destino: Rua das entregas, 700')
    expect(page).to have_content("Ultima Atualização: Galpão de Minas, 25/05/2022, #{order.time.strftime("%R")}")
  end

  it 'order does not have position' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
    user = User.create(name: 'Philipe', email: 'philipe@impact.com.br', password: '12345678')
    company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
    product = Product.create(depth: 10, height: 20, width: 20, weight: 15, sku: 'ASD231ASDS', address: 'Rua viva, 10')
    order = Order.create(receiver_name: 'Pedro', delivery_address: 'Rua das entregas, 700', company: company, product: product)

    visit root_path
    fill_in 'Buscar Pedido', with: order.code
    click_on 'Buscar'

    expect(page).to have_content("Resultado da busca por: #{order.code}")
    expect(page).to have_content('Origem: Rua viva, 10')
    expect(page).to have_content('Destino: Rua das entregas, 700')
    expect(page).to have_content("Ultima Atualização: Ainda não atualizado")
  end

  it 'user do not see search bar' do
    user = User.create(name: 'Philipe', email: 'philipe@impact.com.br', password: '12345678')

    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on 'Entrar'
    end

    expect(page).not_to have_field('Buscar Pedido')
    expect(page).not_to have_button('Buscar')
  end

  it 'admin do not see search bar' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')

    visit root_path
    click_on 'Entrar'
    login_as(admin)
    within('form') do
      click_on 'Entrar'
    end

    expect(page).not_to have_field('Buscar Pedido')
    expect(page).not_to have_button('Buscar')
  end

  it 'returns when click on Voltar' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
    user = User.create(name: 'Philipe', email: 'philipe@impact.com.br', password: '12345678')
    company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
    product = Product.create(depth: 10, height: 20, width: 20, weight: 15, sku: 'ASD231ASDS', address: 'Rua viva, 10')
    order = Order.create(receiver_name: 'Pedro', delivery_address: 'Rua das entregas, 700', company: company, product: product)

    visit root_path
    fill_in 'Buscar Pedido', with: order.code
    click_on 'Buscar'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end
