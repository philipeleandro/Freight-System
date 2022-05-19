require 'rails_helper'

describe 'Company sets its prices' do
  it 'in company index' do
    admin = User.create(name: 'admin', email: 'admin@sistema0deentregas.com.br', password: '12345678')
    company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
    user = User.create(name: 'Impact', email: 'user@impact.com.br', password: '12345678' )

    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Configurar Preço'

    expect(page).to have_content('Configure preço da empresa')
    expect(page).to have_field('Volume Mínimo')
    expect(page).to have_field('Volume Máximo')
    expect(page).to have_field('Peso Mínimo')
    expect(page).to have_field('Peso Máximo')
    expect(page).to have_field('Volume')
  end

  it 'success' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
    company = Company.create(corporate_name: 'Impact LTDA', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
    user = User.create(name: 'impact', email: 'impact@impact.com.br', password: '12345678')

    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Configurar Preço'

    fill_in 'Volume Mínimo', with: '3'
    fill_in 'Volume Máximo', with: '3'
    fill_in 'Peso Mínimo', with: '300'
    fill_in 'Peso Máximo', with: '500'
    fill_in 'Valor', with: '500'
    select 'Impact', from: 'Empresa'
    click_on 'Cadastrar'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Intervalo de preço cadastrado'
  end

  it 'fail' do
    admin = User.create(name: 'admin', email: 'admin@sistema0deentregas.com.br', password: '12345678')
    company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
    user = User.create(name: 'Impact', email: 'user@impact.com.br', password: '12345678' )

    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Configurar Preço'
    select '', from: 'Empresa'
    click_on 'Cadastrar'
  
    expect(page).to have_content 'Verifique os erros abaixo:'
  end

  it 'Returns when click on Voltar' do
    user = User.create(name:'user', email:'admin@magalu.com', password:'12345678')

    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Configurar Preço'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end