require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  context 'logging in' do
    it 'providing valid credentials creates a valid user' do
      user = User.create(name: 'Rspec Testman', password: 'password', email: 'test@example.com')
      expect(User.all).to include user
    end
  end
end
