require 'rails_helper'

describe 'User authentication' do
  it 'success' do
    user = User.create(name: 'Marcos', email: 'email@empresa.com', password: 'password')

    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'email@empresa.com'
    fill_in 'Senha', with: 'password'
    within('form') do
      click_on 'Entrar'
    end

    expect(page).not_to have_link('Entrar')
    expect(page).to have_button('Sair')
    expect(page).to have_content('Login efetuado com sucesso.')
  end

  it 'logout' do
    user = User.create(name: 'Marcos', email: 'email@empresa.com', password: 'password')

    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'email@empresa.com'
    fill_in 'Senha', with: 'password'
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Sair'

    expect(page).to have_link('Entrar')
    expect(page).not_to have_button('Sair')
    expect(page).to have_content('Logout')
  end
end