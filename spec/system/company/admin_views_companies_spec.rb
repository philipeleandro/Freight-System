require 'rails_helper'

describe 'Admin visit homepage' do
  it 'sees system name' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')

    visit root_path
    click_on 'Entrar'
    login_as(admin)
    within('form') do
      click_on 'Entrar'
    end

    expect(page).to have_content('Sistema de Transportadoras')
  end

  it 'sees the registered companies' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
    company = Company.create(corporate_name: 'Impact', domain: 'impact.com.br', brand_name: 'Impact', address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 500, user: admin)
   
    visit root_path
    click_on 'Entrar'
    login_as(admin)
    within('form') do
      click_on 'Entrar'
    end
    
    expect(page).to have_content('Impact')
    expect(page).to have_content('CNPJ: 12345678974568')
    expect(page).to have_content('Frete Mínimo: R$ 100,00 ')
    expect(page).to have_content('Limite: 500km')
  end

  it 'does not exist registered companies' do 
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
    
    visit root_path
    click_on 'Entrar'
    login_as(admin)
    within('form') do
      click_on 'Entrar'
    end

    expect(page).to have_content('Não há transportadoras cadastradas')
  end
end