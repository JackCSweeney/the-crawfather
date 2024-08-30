require 'rails_helper'

RSpec.describe 'User Show Page', type: :feature do
  describe 'As a User' do
    before(:each) do
      user_params = {name: "test", email: "test@email.com", password: "password", password_confirmation: "password", roundup_status: 1}
      @user = User.create!(user_params)
    end

    describe '#Happy Path' do
      before(:each) do
        visit '/'
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        click_button 'Login'
      end

      it 'has a button to go to the users dashboard' do
        click_button 'Dashboard'

        expect(current_path).to eq('/dashboard')
      end

      it 'has a button to logout' do
        expect(page).to have_button('Log Out')
      end

      it 'has a text field to type in the question for the crawfather and a button to submit it' do
        expect(page).to have_field('Question')
        expect(page).to have_button('Ask the Crawfather')
      end
    end
  end
end