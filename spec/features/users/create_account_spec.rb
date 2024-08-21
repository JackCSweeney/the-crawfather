require 'rails_helper'

RSpec.describe 'Create User Account', type: :feature do
  describe 'As a User' do
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
      it 'will not create a new account if not given needed info' do
        user_count = User.all.length
        visit '/users/new'
        
        fill_in 'Name', with: "test name"
        fill_in 'Email Address', with: "test@email.com"
        fill_in 'Password', with: "password"
        within '#enabled' do
          choose 'roundup_status'
        end
        click_button 'Create Account'

        expect(current_path).to eq('/users/new')
        expect(page).to have_content("Password confirmation doesn't match Password")
        expect(user_count).to eq(0)
      end

      it 'will not make an account with an email address that is already taken by a different User' do
        visit '/users/new'

        User.create!({name:"tester", email:"test@email.com", password:"password", password_confirmation:"password", roundup_status:1})

        user_count = User.all.length

        fill_in 'Name', with: "test name"
        fill_in 'Email Address', with: "test@email.com"
        fill_in 'Password', with: "password"
        fill_in 'Password Confirmation', with: "password"
        within '#enabled' do
          choose 'roundup_status'
        end
        click_button 'Create Account'

        expect(current_path).to eq("/users/new")
        expect(page).to have_content("Email has already been taken")
        expect(user_count).to eq(1)
      end
    end
  end
end