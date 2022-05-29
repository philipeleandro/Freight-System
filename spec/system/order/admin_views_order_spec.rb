require 'rails_helper'

describe 'Admin views orders' do
  it 'in admin page' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
    new_company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact',
                                 address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500,
                                 user: admin)
    new_product = Product.create(depth: 10, height: 20, width: 20, weight: 15, sku: 'ASD231ASDS',
                                 address: 'Rua viva, 10')
    Order.create(receiver_name: 'Pedro', delivery_address: 'Rua das entregas, 700', company: new_company,
                 product: new_product)

    visit root_path
    click_on 'Entrar'
    login_as(admin)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Ordens de Serviço'

    expect(page).to have_content('Ordens de Serviço')
    expect(page).to have_content('Status: Pendente')
    expect(page).to have_content('Para: Rua das entregas, 700')
  end

  it 'in admin page' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')

    visit root_path
    click_on 'Entrar'
    login_as(admin)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Ordens de Serviço'

    expect(page).to have_content('Não há ordens de serviço')
  end
end
