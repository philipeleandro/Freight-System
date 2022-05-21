require 'rails_helper'

describe 'Company sets its delivery times' do
  it 'in company index' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
    company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
    user = User.create(name: 'Impact', email: 'user@impact.com.br', password: '12345678' )

    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Configurar Prazo'

    expect(page).to have_content('Configure prazo de entrega da empresa')
    expect(page).to have_field('Distância Mínima')
    expect(page).to have_field('Distância Máxima')
    expect(page).to have_field('Dias Úteis')
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
    click_on 'Configurar Prazo'

    fill_in 'Distância Mínima', with: '30'
    fill_in 'Distância Máxima', with: '300'
    fill_in 'Dias Úteis', with: '1'
    select 'Impact', from: 'Empresa'
    click_on 'Cadastrar'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Intervalo de prazo cadastrado'
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
    click_on 'Configurar Prazo'
    select '', from: 'Empresa'
    click_on 'Cadastrar'
  
    expect(page).to have_content 'Verifique os erros abaixo:'
  end

  it 'user does not have registered company' do
    user = User.create(name: 'Impact', email: 'user@impact.com.br', password: '12345678' )

    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Configurar Prazo'
  
    expect(page).to have_field 'Empresa'
    expect(page).to have_select('Empresa', selected: "")
  end

  it 'Returns when click on Voltar' do
    user = User.create(name:'user', email:'admin@magalu.com', password:'12345678')

    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Configurar Prazo'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end