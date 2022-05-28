require 'rails_helper'

describe 'Company user registers new car' do
  it 'in company index' do
    user = User.create(name:'user', email:'admin@magalu.com', password:'12345678')

    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Cadastrar Carro'

    expect(page).to have_field('Placa')
    expect(page).to have_field('Marca')
    expect(page).to have_field('Modelo')
    expect(page).to have_field('Carregamento Máximo')
    expect(page).to have_field('Ano')
    expect(page).to have_field('Empresa')
  end

  it 'success' do
    admin = User.create(name:'admin', email:'admin@sistemadeentregas.com.br', password:'12345678')
    user = User.create(name:'user', email:'admin@company.com.br', password:'12345678')
    company = Company.create(corporate_name: 'Company LTDA', domain: 'company.com.br', brand_name: 'Company', address: 'Rua das flores, 1000', cnpj: '12345678974125', freight: 100, threshold: 500, user: admin)

    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Cadastrar Carro'
    fill_in 'Placa', with: 'ABX-1234'
    fill_in 'Marca', with: 'Volkswagem'
    fill_in 'Modelo', with: 'Gol'
    fill_in 'Carregamento Máximo', with: '300'
    fill_in 'Ano', with: '2015'
    select 'Company', from: 'Empresa'
    click_on 'Cadastrar'

    expect(page).to have_content('Cadastrado com Sucesso')
    expect(current_path).to eq root_path
  end

  it 'incomplete data' do
    admin = User.create(name:'admin', email:'admin@sistemasdeentregas.com.br', password:'12345678')
    user = User.create(name:'user', email:'admin@magalu.com', password:'12345678')
    company = Company.create(corporate_name: 'Company LTDA', domain: 'company.com', brand_name: 'Company', address: 'Rua das flores, 1000', cnpj: '12345678904789', freight: 100, threshold: 500, user: admin)

    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Cadastrar Carro'
    fill_in 'Placa', with: ''
    fill_in 'Marca', with: ''
    fill_in 'Modelo', with: ''
    fill_in 'Carregamento Máximo', with: ''
    fill_in 'Ano', with: ''
    select '', from: 'Empresa'
    click_on 'Cadastrar'

    expect(page).to have_content('Carro não cadastrado')
    expect(page).to have_content('Verifique os erros abaixo')
  end

  it 'Returns when click on Voltar' do
    user = User.create(name:'user', email:'admin@magalu.com', password:'12345678')

    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Cadastrar Carro'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  it 'user does not have registered company' do
    user = User.create(name: 'Impact', email: 'user@impact.com.br', password: '12345678' )

    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Cadastrar Carro'
  
    expect(page).to have_field 'Empresa'
    expect(page).to have_select('Empresa', selected: "")
  end

  it 'user belong another company' do
    admin = User.create(name:'admin', email:'admin@sistemasdeentregas.com.br', password:'12345678')
    user = User.create(name:'user', email:'admin@magalu.com.br', password:'12345678')
    company = Company.create(corporate_name: 'Company LTDA', domain: 'company.com.br', brand_name: 'Company', address: 'Rua das flores, 1000', cnpj: '12345678974125', freight: 100, threshold: 500, user: admin)


    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Cadastrar Carro'
    click_on 'Cadastrar'

  
    expect(page).to have_content("Carro não cadastrado")
  end 

  it 'admin tries to access new car page' do
    admin = User.create(name:'admin', email:'admin@sistemadeentregas.com.br', password:'12345678')

    visit root_path
    click_on 'Entrar'
    login_as(admin)
    within('form') do
      click_on 'Entrar'
    end
    visit new_car_path

    expect(current_path).to eq companies_path
    expect(page).to have_content('Erro ao carregar a página')
  end
end
