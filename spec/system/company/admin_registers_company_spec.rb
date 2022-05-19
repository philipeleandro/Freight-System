require 'rails_helper'

describe 'Admin registers new company' do
  it 'in admin homepage' do
    admin = User.create(name:'admin', email:'admin@sistemadeentregas.com.br', password:'12345678')

    visit root_path
    click_on 'Entrar'
    login_as(admin)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Cadastrar Empresa'

    expect(page).to have_field('Razão Social')
    expect(page).to have_field('Nome Fantasia')
    expect(page).to have_field('CNPJ')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Domínio')
    expect(page).to have_field('Frete Mínimo')
    expect(page).to have_field('Limite')
  end

  it 'success' do
    admin = User.create(name:'admin', email:'admin@sistemadeentregas.com.br', password:'12345678')

    visit root_path
    click_on 'Entrar'
    login_as(admin)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Cadastrar Empresa'
    fill_in 'Razão Social', with: 'CNB LTDA'
    fill_in 'Nome Fantasia', with: 'CNB'
    fill_in 'CNPJ', with: '12345678945612'
    fill_in 'Endereço', with: 'Rua da flores, 1000'
    fill_in 'Domínio', with: 'cnb.com.br'
    fill_in 'Frete Mínimo', with: 200
    fill_in 'Limite', with: 3000
    select admin.id, from: 'User'
    click_on 'Cadastrar'

    expect(current_path).to eq companies_path
    expect(page).to have_content('Cadastrado com sucesso')
    expect(page).to have_content('CNB')
    expect(page).to have_content('CNPJ: 12345678945612')
    expect(page).to have_content('Frete Mínimo: R$ 200,00 ')
    expect(page).to have_content('Limite: 3000km ')
  end

  it 'not admin' do
    user = User.create(name:'user', email:'admin@sistemadeentregas.com', password:'12345678')

    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on 'Entrar'
    end
    visit companies_path

    expect(current_path).to eq root_path
    expect(page).to have_content('Página não pode ser carregada')
  end

  it 'Returns when click on Voltar' do
    admin = User.create(name:'admin', email:'admin@sistemadeentregas.com.br', password:'12345678')

    visit root_path
    click_on 'Entrar'
    login_as(admin)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Cadastrar Empresa'
    click_on 'Voltar'

    expect(current_path).to eq companies_path
  end
end