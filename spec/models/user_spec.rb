require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when user does not have a name' do
        user = User.create(name: '', email: 'philipe@example.com', password: '12345678')

        expect(user.valid?).to eq false
      end
    end
  end
end
