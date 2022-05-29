require 'rails_helper'

describe 'User views homepage' do
  it 'sees app name' do
    visit root_path

    expect(page).to have_content('Sistema de Transportadoras')
  end
end
