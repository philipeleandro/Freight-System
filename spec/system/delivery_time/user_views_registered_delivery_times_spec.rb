require 'rails_helper'

describe 'User views delivery time' do
  it 'saw delivery times registered' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
    company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
    user = User.create(name: 'Impact', email: 'user@impact.com.br', password: '12345678' )
    delivery_time = DeliveryTime.create(min_distance: 1, max_distance: 3, days: 5, company: company)

    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Tabela de Prazos'

    expect(page).to have_content("Distância Mínima")
    expect(page).to have_content("Distância Máxima")
    expect(page).to have_content("Dias Úteis")
    expect(page).to have_content("1")
    expect(page).to have_content("3")
    expect(page).to have_content("5")
  end

  it 'does not have registered delivery times' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
    company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
    user = User.create(name: 'Impact', email: 'user@impact.com.br', password: '12345678' )
   

    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Tabela de Prazos'

    expect(page).to have_content("Não há prazos cadastrados")
  end

  it 'Returns when click on Voltar' do
    user = User.create(name:'user', email:'admin@magalu.com', password:'12345678')

    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Tabela de Prazos'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  it 'admin tries to access new price page' do
    admin = User.create(name:'admin', email:'admin@sistemadeentregas.com.br', password:'12345678')

    visit root_path
    click_on 'Entrar'
    login_as(admin)
    within('form') do
      click_on 'Entrar'
    end
    visit new_delivery_time_path

    expect(current_path).to eq companies_path
    expect(page).to have_content('Erro ao carregar a página')
  end
end