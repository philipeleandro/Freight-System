require 'rails_helper'

describe 'Admin searches companies prices' do
  it 'and sees the register fields' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')

    visit root_path
    click_on 'Entrar'
    login_as(admin)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Consulta de Preço'

    expect(page).to have_content('Busca de Preço')
    expect(page).to have_field('Peso')
    expect(page).to have_field('Altura')
    expect(page).to have_field('Largura')
    expect(page).to have_field('Profundidade')
    expect(page).to have_field('Distância')
  end

  it 'only admin can access this page' do
    user = User.create(name: 'Impact', email: 'user@impact.com.br', password: '12345678')

    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on 'Entrar'
    end
    visit check_price_companies_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Página indisponível')
  end

  it 'did not find any result' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')

    visit root_path
    click_on 'Entrar'
    login_as(admin)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Consulta de Preço'
    click_on 'Buscar'

    expect(page).to have_content('Resultado:')
    expect(page).to have_content('Nenhuma empresa disponível')
  end

  it 'success' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
    User.create(name: 'Impact', email: 'user@impact.com.br', password: '12345678')
    company_one = Company.create(corporate_name: 'Impact LTDA', domain: 'impact.com.br', brand_name: 'Impact',
                                 address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 25, threshold: 15,
                                 user: admin)
    company_two = Company.create(corporate_name: 'Company LTDA', brand_name: 'Company',
                                 address: 'Rua das flores, 1000', domain: 'company.com.br', cnpj: '12345678911234',
                                 freight: 20, threshold: 30, user: admin)
    DeliveryTime.create!(min_distance: 0, max_distance: 100, days: 5, company: company_one)
    DeliveryTime.create!(min_distance: 0, max_distance: 100, days: 7, company: company_two)
    Price.create!(min_volume: 1, max_volume: 20, min_weight: 1, max_weight: 20, value: 1, company: company_one)
    Price.create!(min_volume: 21, max_volume: 50, min_weight: 21, max_weight: 50, value: 2, company: company_one)
    Price.create!(min_volume: 1, max_volume: 20, min_weight: 1, max_weight: 20, value: 3, company: company_two)
    Price.create!(min_volume: 21, max_volume: 50, min_weight: 21, max_weight: 50, value: 5, company: company_two)

    visit root_path
    click_on 'Entrar'
    login_as(admin)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Consulta de Preço'
    fill_in 'Peso', with: '10'
    fill_in 'Altura', with: '200'
    fill_in 'Largura', with: '100'
    fill_in 'Profundidade', with: '100'
    fill_in 'Distância', with: '10'
    click_on 'Buscar'

    expect(page).to have_content('Resultado:')
    expect(page).to have_content('Transportadora: Impact LTDA')
    expect(page).to have_content('Valor Frete: R$ 25,00')
    expect(page).to have_content('Prazo: 5 dia(s) útil')
    expect(page).to have_content('Transportadora: Company LTDA')
    expect(page).to have_content('Valor Frete: R$ 30,00')
    expect(page).to have_content('Prazo: 7 dia(s) útil')
  end

  it 'success showing the bigger price for company' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
    User.create(name: 'Impact', email: 'user@impact.com.br', password: '12345678')
    company_one = Company.create(corporate_name: 'Impact LTDA', domain: 'impact.com.br', brand_name: 'Impact',
                                 address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 100, threshold: 50,
                                 user: admin)
    company_two = Company.create(corporate_name: 'Company LTDA', brand_name: 'Company',
                                 address: 'Rua das flores, 1000', domain: 'company.com.br', cnpj: '12345678911234',
                                 freight: 70, threshold: 40, user: admin)
    DeliveryTime.create!(min_distance: 0, max_distance: 100, days: 5, company: company_one)
    DeliveryTime.create!(min_distance: 0, max_distance: 100, days: 7, company: company_two)
    Price.create!(min_volume: 1, max_volume: 20, min_weight: 1, max_weight: 20, value: 1, company: company_one)
    Price.create!(min_volume: 21, max_volume: 50, min_weight: 21, max_weight: 50, value: 2, company: company_one)
    Price.create!(min_volume: 1, max_volume: 20, min_weight: 1, max_weight: 20, value: 3, company: company_two)
    Price.create!(min_volume: 21, max_volume: 50, min_weight: 21, max_weight: 50, value: 5, company: company_two)

    visit root_path
    click_on 'Entrar'
    login_as(admin)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Consulta de Preço'
    fill_in 'Peso', with: '10'
    fill_in 'Altura', with: '200'
    fill_in 'Largura', with: '100'
    fill_in 'Profundidade', with: '100'
    fill_in 'Distância', with: '10'
    click_on 'Buscar'

    expect(page).to have_content('Resultado:')
    expect(page).to have_content('Transportadora: Impact LTDA')
    expect(page).to have_content('Valor Frete: R$ 100,00')
    expect(page).to have_content('Prazo: 5 dia(s) útil')
    expect(page).to have_content('Transportadora: Company LTDA')
    expect(page).to have_content('Valor Frete: R$ 70,00')
    expect(page).to have_content('Prazo: 7 dia(s) útil')
  end

  it 'success showing the bigger price using distance * value' do
    admin = User.create(name: 'admin', email: 'admin@sistemadeentregas.com.br', password: '12345678')
    User.create(name: 'Impact', email: 'user@impact.com.br', password: '12345678')
    company_one = Company.create(corporate_name: 'Impact LTDA', domain: 'impact.com.br', brand_name: 'Impact',
                                 address: 'Rua das flores, 1000', cnpj: '12345678974568', freight: 10, threshold: 50,
                                 user: admin)
    company_two = Company.create(corporate_name: 'Company LTDA', brand_name: 'Company',
                                 address: 'Rua das flores, 1000', domain: 'company.com.br', cnpj: '12345678911234',
                                 freight: 10, threshold: 40, user: admin)
    DeliveryTime.create!(min_distance: 0, max_distance: 100, days: 5, company: company_one)
    DeliveryTime.create!(min_distance: 0, max_distance: 100, days: 7, company: company_two)
    Price.create!(min_volume: 1, max_volume: 20, min_weight: 1, max_weight: 20, value: 2, company: company_one)
    Price.create!(min_volume: 21, max_volume: 50, min_weight: 21, max_weight: 50, value: 2, company: company_one)
    Price.create!(min_volume: 1, max_volume: 20, min_weight: 1, max_weight: 20, value: 3, company: company_two)
    Price.create!(min_volume: 21, max_volume: 50, min_weight: 21, max_weight: 50, value: 5, company: company_two)

    visit root_path
    click_on 'Entrar'
    login_as(admin)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Consulta de Preço'
    fill_in 'Peso', with: '10'
    fill_in 'Altura', with: '200'
    fill_in 'Largura', with: '100'
    fill_in 'Profundidade', with: '100'
    fill_in 'Distância', with: '10'
    click_on 'Buscar'

    expect(page).to have_content('Resultado:')
    expect(page).to have_content('Transportadora: Impact LTDA')
    expect(page).to have_content('Valor Frete: R$ 20,00')
    expect(page).to have_content('Prazo: 5 dia(s) útil')
    expect(page).to have_content('Transportadora: Company LTDA')
    expect(page).to have_content('Valor Frete: R$ 30,00')
    expect(page).to have_content('Prazo: 7 dia(s) útil')
  end
end
