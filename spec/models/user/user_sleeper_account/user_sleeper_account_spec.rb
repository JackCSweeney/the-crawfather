require 'rails_helper'

RSpec.describe UserSleeperAccount do
  describe 'Validations' do
    it { should validate_presence_of(:sleeper_username) }
    it { should validate_presence_of(:sleeper_user_id) }
    it { should validate_presence_of(:user_id) }
    it { should belong_to :user }
  end

  describe '.class methods' do
    before(:each) do
      @user = User.create!({name: "test", email: "test@email.com", password: "password", password_confirmation: "password", roundup_status: 1})
      @sleeper_username = "SweeneysWeenies"
      @sleeper_user_id = 12345678
    end

    describe '.get_id_and_create(sleeper_username, user_id)' do
      it 'will retrieve the associated sleeper_user_id from the sleeper api and create a new record in the database with the users sleeper account information associate with the user record in local DB' do
        user_sleeper_account = UserSleeperAccount.get_id_and_create(@sleeper_username, @user.id)

        expect(user_sleeper_account).to be_a(UserSleeperAccount)
        expect(user_sleeper_account.sleeper_username).to eq(@sleeper_username)
        expect(user_sleeper_account.sleeper_user_id).to eq(@sleeper_user_id)
        expect(@user.user_sleeper_accounts).to eq([user_sleeper_account])
      end
    end

    describe '.get_sleeper_user_id(sleeper_username)' do
      it 'retrieves the given users sleeper_user_id from the sleeper api' do
        result = UserSleeperAccount.get_sleeper_user_id(@sleeper_username)

        expect(result).to eq(@sleeper_user_id)
      end
    end
  end
end