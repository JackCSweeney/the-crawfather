require 'rails_helper'

RSpec.describe 'Create User Account', type: :feature do
  describe 'As a User' do
    before(:each) do
      
    end

    describe '#Happy Path' do
      it 'can visit the landing page and see an option to create a new account or to sign in' do
        visit '/'

        expect(page).to have_content("The Crawfather awaits...")
        expect(page).to have_button("Login")
        expect(page).to have_link("Create Account", href: "/users/new")
      end

      it 'can click the create an account button and be taken to the page to create their account' do
        visit '/'
        click_link 'Create Account'

        expect(current_path).to eq('/users/new')
        
        fill_in 'Name', with: "test name"
        fill_in 'Email Address', with: "test@email.com"
        fill_in 'Password', with: "password"
        fill_in 'Password Confirmation', with: "password"
        within '#enabled' do
          choose 'roundup_status'
        end
        click_button 'Create Account'

        expect(current_path).to eq('/home')
        expect(User.all.last.name).to eq("test name")
      end
    end

    describe '#Sad Path' do
      it '' do

      end
    end
  end
end