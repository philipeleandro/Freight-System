require 'rails_helper'

describe 'User views prices' do
  it 'saw registered prices' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
    company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
    user = User.create(name: 'Impact', email: 'user@impact.com.br', password: '12345678' )
    price = Price.create(min_volume: 1, max_volume: 20, min_weight: 10, max_weight: 20, value: 50, company: company)

    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Tabela de Preços'

    expect(page).to have_content("Volume Mínimo")
    expect(page).to have_content("Volume Máximo")
    expect(page).to have_content("Peso Mínimo")
    expect(page).to have_content("Peso Máximo")
    expect(page).to have_content("Valor")
    expect(page).to have_content("1")
    expect(page).to have_content("20")
    expect(page).to have_content("10")
    expect(page).to have_content("20")
    expect(page).to have_content("R$ 50,00")
  end

  it 'does not have registered prices' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
    company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
    user = User.create(name: 'Impact', email: 'user@impact.com.br', password: '12345678' )
   

    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Tabela de Preços'

    expect(page).to have_content("Não há preços cadastrados")
  end

  it 'Returns when click on Voltar' do
    user = User.create(name:'user', email:'admin@magalu.com', password:'12345678')

    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Tabela de Preços'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  it 'admin tries to access new price table page' do
    admin = User.create(name:'admin', email:'admin@sistemadeentregas.com.br', password:'12345678')

    visit root_path
    click_on 'Entrar'
    login_as(admin)
    within('form') do
      click_on 'Entrar'
    end
    visit prices_path

    expect(current_path).to eq companies_path
    expect(page).to have_content('Erro ao carregar a página')
  end
end