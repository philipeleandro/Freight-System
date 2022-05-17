require 'rails_helper'

describe 'User authentication' do
  it 'success' do
    user = User.create(name: 'Marcos', email: 'email@sistemadeentregas.com.br', password: 'password')

    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on 'Entrar'
    end

    expect(page).not_to have_link('Entrar')
    expect(page).to have_button('Sair')
  end

  it 'logout' do
    user = User.create(name: 'Marcos', email: 'email@sistemadeentregas.com.br', password: 'password')

    visit root_path
    click_on 'Entrar'
    login_as(user)
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Sair'

    expect(page).to have_link('Entrar')
    expect(page).not_to have_button('Sair')
  end
end