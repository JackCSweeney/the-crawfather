require 'rails_helper'

RSpec.describe 'User Edit Account' do
  describe 'As a User' do
    before(:each) do
      @user = User.create!({name: "test", email: "test@email.com", password: "password", password_confirmation: "password", roundup_status: 1})
      visit '/'
      fill_in 'Email', with: "test@email.com"
      fill_in 'Password', with: "password"
      click_button 'Login'
    end

    describe '#Happy Path' do
      it 'can see an option to edit the account from the user dashboard' do
        visit '/dashboard'
        expect(page).to have_button('Edit Account')
      end

      it 'can click the button to edit their account and be taken to a page where they see their current info and have the ability to change any of it' do
        visit '/dashboard'
        click_button ('Edit Account')

        expect(current_path).to eq('/edit')
        expect(page).to have_field('name')
        expect(page).to have_field('email')
        expect(page).to have_button('Update Account')
        expect(page).to have_button('Update Password')
      end

      it 'can update the information in the edit form and it will be saved to the associated user in the database' do
        visit '/dashboard'
        click_button ('Edit Account')

        fill_in 'name', with: 'test 2'
        click_on 'Update Account'

        expect(current_path).to eq('/dashboard')
        expect(page).to have_content('Account successfully updated')
        expect(User.find(@user.id).name).to eq('test 2')
      end

      it 'can update different information in the edit form and it will be saved to the associated user in the database' do
        visit '/dashboard'
        click_button ('Edit Account')

        fill_in 'email', with: 'test2@email.com'
        click_on 'Update Account'

        expect(current_path).to eq('/dashboard')
        expect(page).to have_content('Account successfully updated')
        expect(User.find(@user.id).email).to eq('test2@email.com')
      end
    end
  end
end