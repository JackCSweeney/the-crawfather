require 'rails_helper'

RSpec.describe 'User Dashboard Page' do
  describe 'As a logged in User' do 
    
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

      q_1 = @user.questions[4]
      q_2 = @user.questions[3]
      q_3 = @user.questions[2]
      q_4 = @user.questions[1]
      q_5 = @user.questions[0]
      @questions = [q_1, q_2, q_3, q_4, q_5]
    end
    
    it 'sees its own name, number of credits left, the last 5 questions its asked, the responses' do
      visit '/dashboard'
      
      expect(page).to have_content("Name: test")
      expect(page).to have_content("Credits Remaining: 5")
      expect(page).to have_content("Last 5 Questions for the Crawfather:")
      @questions.each do |question|
        within "#question-#{question.id}" do
          expect(page).to have_content("Question")
          expect(page).to have_content("Response")
      end
    end
  end
  
  it 'sees a button to delete its account' do
    visit '/dashboard'
    expect(page).to have_button("Delete Account")
  end

  it 'sees a button to return to the crawfather to ask more questions' do
      visit '/dashboard'
      click_button 'Return to the Crawfather'
      
      expect(current_path).to eq('/home')
    end
  end

  describe 'As a not logged in user' do
    it 'does not allow you to see your dashboard unless you are logged in' do
      visit '/dashboard'
    
      expect(current_path).to eq('/')
      expect(page).to have_content('You must be logged in to view your dashboard page')
    end
  end
end