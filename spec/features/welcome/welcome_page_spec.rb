require 'rails_helper'

RSpec.describe 'Welcome Page', type: :feature do
  describe 'As a visitor' do
    it 'can see the welcome page info and login form' do
      visit '/'

      expect(page).to have_content("The Crawfather awaits...")
      expect(page).to have_field("email")
      expect(page).to have_field("password")
      expect(page).to have_button("Login")
      expect(page).to have_link("Create Account", href: "/users/new")
    end
  end
end