require 'rails_helper'

describe 'Admin views companies' do
  it 'in admin homepage' do
    admin = User.create(name: "Philipe", email: "testing@sistemadeentregas.com.br", password:'12345678')

    visit root_path
    click_on 'Entrar'
    login_as(admin)
    within('form') do
      click_on 'Entrar'
    end

    expect(page).to have_content('Admin')
  end

  it 'must be logged in' do
    visit root_path
    visit '/companies'

    expect(page).to have_content('Para continuar, faça login ou registre-se.')
  end
end