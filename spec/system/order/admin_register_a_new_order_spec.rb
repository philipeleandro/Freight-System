require 'rails_helper'

describe 'Admin register a new order' do
  it 'in admin page' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
    company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)

    visit root_path
    click_on 'Entrar'
    login_as(admin)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Criar Ordem de Serviço'

    expect(page).to have_content('Informações do Produto')
    expect(page).to have_field('Altura')
    expect(page).to have_field('Largura')
    expect(page).to have_field('Profundidade')
    expect(page).to have_field('Peso')
    expect(page).to have_field('Endereço do Produto')
    expect(page).to have_field('SKU')
    expect(page).to have_content('Informações da Ordem de Serviço')
    expect(page).to have_field('Transportadora')
    expect(page).to have_field('Nome do Destinatário')
    expect(page).to have_field('Destinatário')
  end

  it 'success' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
    company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
    

    visit root_path
    click_on 'Entrar'
    login_as(admin)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Criar Ordem de Serviço'

    fill_in 'Altura', with: '30'
    fill_in 'Largura', with: '60'
    fill_in 'Profundidade', with: '60'
    fill_in 'Peso', with: '40'
    fill_in 'Endereço do Produto', with: 'Rua das dores, 50'
    fill_in 'SKU', with: 'ASDQWE5674'
    fill_in 'Nome do Destinatário', with: 'Lucas Andrade'
    fill_in 'Destinatário', with: 'Rua da luta, 1500'
    select 'Impact', from: 'Transportadora'
    click_on 'Cadastrar'

    expect(current_path).to eq companies_path
    expect(page).to have_content('Ordem de serviço cadastrada')
  end

  it 'fail' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
    company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '74125896321456', freight: 100, threshold: 500, user: admin)

    visit root_path
    click_on 'Entrar'
    login_as(admin)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Criar Ordem de Serviço'
    select 'Impact', from: 'Transportadora'
    click_on 'Cadastrar'

    expect(page).to have_content 'Verifique os erros abaixo:'
    expect(page).to have_content 'Ordem de serviço não cadastrado'
  end

  it 'Returns when click on Voltar' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
    company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)

    visit root_path
    click_on 'Entrar'
    login_as(admin)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Criar Ordem de Serviço'
    click_on 'Voltar'


    expect(current_path).to eq companies_path
  end
end