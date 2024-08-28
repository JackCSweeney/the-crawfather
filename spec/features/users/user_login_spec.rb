require 'rails_helper'

RSpec.describe 'User', type: :feature do
  describe 'As a User' do
    before(:each) do
      user_params = {name: "test", email: "test@email.com", password: "password", password_confirmation: "password", roundup_status: 1}
      @user = User.create!(user_params)
    end

    it 'can login from the home page' do
      visit '/'

      fill_in 'Email', with: "test@email.com"
      fill_in 'Password', with: "password"
      click_button 'Login'

      expect(current_path).to eq("/home")
      expect(session[:user_id]).to eq(@user.id)
    end
  end
end