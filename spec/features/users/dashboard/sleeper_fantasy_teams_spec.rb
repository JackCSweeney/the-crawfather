require 'rails_helper'

RSpec.describe 'Sleeper Fantasy Teams on User Dashboard' do
  describe 'As a User' do
    before(:each) do
      user_params = {name: "test", email: "test@email.com", password: "password", password_confirmation: "password", roundup_status: 1}
      @user = User.create!(user_params)
      @sleeper_league_id = 1048290741539241984
      @sleeper_username = "SweeneysWeenies"
    end

    describe '#Happy Path' do
      before(:each) do
        visit '/'
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        click_button 'Login'
        click_button 'Dashboard'
      end

      it 'has a field and button to add a sleeper league to your account by league id' do
        within '#sleeper_leagues' do
          within '#add_a_league' do
            expect(page).to have_content('Add Sleeper League by League ID & Username (Can be found in League General Settings)')

            within '#league_id' do
              expect(page).to have_content('Sleeper League ID')
              expect(page).to have_field('sleeper_league_id')
            end

            with '#username' do
              expect(page).to have_content('Sleeper Username')
              expect(page).to have_field('username')
            end

            expect(page).to have_button('Add League')
          end
        end
      end

      it 'can enter a valid league id and username and see the team populate on their user dashboard' do
        within '#sleeper_leagues' do
          within '#add_a_league' do
            within '#league_id' do
              fill_in 'sleeper_league_id', with: @sleeper_league_id
            end
            within '#username' do
              fill_in 'username', with: @sleeper_username
            end

            click_button 'Add League'
          end
        end

        expect(current_path).to eq('/dashboard')
        
        within '#sleeper_leagues' do
          within '#current_leagues' do
            expect(page).to have_content('Dynasty Daddies')
            expect(page).to have_select('Week', options: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18'], selected: '4')

            within '#record' do
              expect(page).to have_content('Current Record: 1 - 2')
            end

            within '#current_points' do
              expect(page).to have_content('')
            end

            within '#current_opponent_points' do
              expect(page).to have_content('')
            end
            
            within '#starters' do
              expect(page).to have_content('Josh Allen')
              expect(page).to have_content('James Cook')
              expect(page).to have_content('David Montgomery')
              expect(page).to have_content('Mike Evans')
              expect(page).to have_content('Jordan Addison')
              expect(page).to have_content('Khalil Shakir')
              expect(page).to have_content('George Kittle')
              expect(page).to have_content('Chuba Hubbard')
              expect(page).to have_content('Sam Darnold')
              expect(page).to have_content('Daniel Carlson')
            end
          end
        end
      end
    end
  end
end



