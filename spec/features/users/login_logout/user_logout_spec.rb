require 'rails_helper'

RSpec.describe 'User Logout' do
  describe 'As a User' do
    before(:each) do
      User.create!({name: "test", email: "test@email.com", password: "password", password_confirmation: "password", roundup_status: 1})
      visit '/'
      fill_in 'Email', with: "test@email.com"
      fill_in 'Password', with: "password"
      click_button 'Login'
    end

    describe '#Happy Path' do
      it 'can see the logout button from the home page after logging in' do
        expect(current_path).to eq('/home')
        expect(page).to have_button('Log Out')
      end

      it 'can click the logout button and be returned to the root page' do
        click_button 'Log Out'

        expect(current_path).to eq('/')
        expect(page).to have_content('You have successfully logged out')
      end

      it 'will not be able to visit the home page again until logging back in' do
        click_button 'Log Out'
        visit '/home'

        expect(page).to have_content('You must be logged in to speak with The Crawfather')
      end
    end
  end
end
