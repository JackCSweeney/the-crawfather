require 'rails_helper'

RSpec.describe 'User Dashboard Page' do
  describe 'As a User' do 
    before(:each) do
      user_params = {name: "test", email: "test@email.com", password: "password", password_confirmation: "password", roundup_status: 1}
      @user = User.create!(user_params)
      visit '/'
      fill_in 'Email', with: "test@email.com"
      fill_in 'Password', with: "password"
      click_button 'Login'

      5.times do
        create(:question, user_id: @user.id)
      end
    end
# Show name and list of questions asked
# Button to return to the crawfather
# Button to edit account
# Button to activate/deactivate weekly round up emails
# Button to delete account
    it 'sees its own name, number of credits left, the last 5 questions its asked, the responses, and their dates in the dashboard' do
      visit '/dashboard'

      expect(page).to have_content("Name: test")
      expect(page).to have_content("Credits Remaining: 5")
      expect(page).to have_content("Last 5 Questions for the Crawfather:")
      (1..5).each do |num|
        within "#question-#{num}" do
          expect(page).to have_content("Question")
          expect(page).to have_content("Response")
        end
      end
    end

    it 'sees a button to delete its account' do
      visit '/dashboard'
      expect(page).to have_button("Delete Account")
    end

    it 'sees options to enable or disable their weekly roundup emails' do
      visit '/dashboard'

      within '#enabled' do
        expect(page).to have_field('roundup_status')
      end
      
      within '#disabled' do
        expect(page).to have_field('roundup_status')
      end
    end

    it 'sees a button to return to the crawfather to ask more questions' do
      visit '/dashboard'
      click_button 'Return to the Crawfather'

      expect(current_path).to eq('/home')
    end
  end
end