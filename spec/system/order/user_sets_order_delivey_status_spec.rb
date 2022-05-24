require 'rails_helper'

describe 'User update delivey status' do
  it 'User does not see link to update position' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
    user = User.create(name: 'Philipe', email: 'philipe@impact.com.br', password: '12345678')
    company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
    product = Product.create(depth: 10, height: 20, width: 20, weight: 15, sku: 'ASD231ASDS', address: 'Rua viva, 10')
    order = Order.create(receiver_name: 'Pedro', delivery_address: 'Rua das entregas, 700', company: company, product: product)
    order_two = Order.create(status: 'finished', receiver_name: 'Pedro', delivery_address: 'Rua das entregas, 700', company: company, product: product)
    order_two = Order.create(status: 'refused', receiver_name: 'Pedro', delivery_address: 'Rua das entregas, 700', company: company, product: product)

    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on('Entrar')
    end
    click_on 'Serviços'

    expect(page).not_to have_link('Atualizar rota do pedido')
  end

  it 'User sees link to update position' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
    user = User.create(name: 'Philipe', email: 'philipe@impact.com.br', password: '12345678')
    company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
    product = Product.create(depth: 10, height: 20, width: 20, weight: 15, sku: 'ASD231ASDS', address: 'Rua viva, 10')
    order = Order.create(status: 'in_progress', receiver_name: 'Pedro', delivery_address: 'Rua das entregas, 700', company: company, product: product)
    order_two = Order.create(status: 'accepted', receiver_name: 'Pedro', delivery_address: 'Rua das entregas, 700', company: company, product: product)

    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on('Entrar')
    end
    click_on 'Serviços'

    expect(page).to have_link('Atualizar rota do pedido')
  end

  it 'success' do
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
    click_on 'Finalizar'
    click_on 'Atualizar rota do pedido'
    select 'Em Progresso', from: 'Status'
    fill_in 'Posição', with: 'A caminho do galpão de Juazeiro do Norte'
    fill_in 'Data', with: '10/12/2022'
    fill_in 'Horário', with: '13:59'
    click_on 'Finalizar'

    expect(page).to have_content('Status: Em Progresso')
    expect(page).to have_content('Rua das entregas, 700')
    expect(page).to have_content('Última atualização: A caminho do galpão de Juazeiro do Norte, 10/12/2022 - 13:59')
  end

  it 'incomplete data' do
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
    click_on 'Finalizar'
    click_on 'Atualizar rota do pedido'
    select 'Em Progresso', from: 'Status'
    click_on 'Finalizar'

    expect(page).to have_content('Verifique se local, horário e data foram preenchidos corretamente. Atualiza mais uma vez!')
  end
end