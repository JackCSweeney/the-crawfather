require 'rails_helper'

RSpec.describe 'User', type: :feature do
  describe 'As a User' do
    before(:each) do
      user_params = {name: "test", email: "test@email.com", password: "password", password_confirmation: "password", roundup_status: 1}
      @user = User.create!(user_params)
    end

    describe '#Happy Path' do
      it 'can login from the home page' do
        visit '/'

        fill_in 'Email', with: "test@email.com"
        fill_in 'Password', with: "password"
        click_button 'Login'

        expect(current_path).to eq("/home")
        # want to figure out how to check the session for the user_id here
        # expect().to eq(@user.id)
      end
    end

    describe '#Sad Path' do
      it 'will not login if given the wrong email' do
        visit '/'

        fill_in 'Email', with: "bad@email.com"
        fill_in 'Password', with: "password"
        click_button 'Login'

        expect(current_path).to eq('/')
        expect(page).to have_content("Error: Email or Password is incorrect")
      end

      it 'will not login if given the wrong password' do
        visit '/'

        fill_in 'Email', with: "test@email.com"
        fill_in 'Password', with: "bad password"
        click_button 'Login'

        expect(current_path).to eq('/')
        expect(page).to have_content("Error: Email or Password is incorrect")
      end
    end
  end
end