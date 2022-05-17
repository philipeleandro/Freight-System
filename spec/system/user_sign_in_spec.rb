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

  it 'fail' do
    User.create(name: 'Marcos', email: 'email@sistemadeentregas.com.br', password: 'password')

    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'email@sistemadeentregas.com'
    fill_in 'Senha', with: '123547888'
    within('form') do
      click_on 'Entrar'
    end

    expect(current_path).to eq('/users/sign_in')
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