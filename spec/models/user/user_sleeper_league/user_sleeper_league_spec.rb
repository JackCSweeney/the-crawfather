require 'rails_helper'

RSpec.describe UserSleeperLeague do
  describe 'validations' do
    it { should validate_presence_of(:sleeper_league_name) }
    it { should validate_presence_of(:sleeper_league_id) }
    it { should validate_numericality_of(:sleeper_league_id) }
    it { should belong_to :user }
  end

  before(:each) do
    @user = User.create!({name: "test", email: "test@email.com", password: "password", password_confirmation: "password", roundup_status: 1})
    @sleeper_league_id = 1048290741539241984

    json_response = File.read("spec/fixtures/sleeper_league_by_league_id.json")
    stub_request(:get, "https://api.sleeper.app/v1/league/1048290741539241984").
    with(
     headers: {
     'Accept'=>'*/*',
     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     'User-Agent'=>'Faraday v2.10.1'
      }).
    to_return(status: 200, body: json_response, headers: {})    
  end

  describe '.class methods' do
    describe '.get_league_and_create(sleeper_league_id, user_id)' do
      it 'can retrieve the sleeper leagues name and create a new record associated with the user when given the league id and the user id' do
        user_sleeper_league = UserSleeperLeague.get_league_and_create(@sleeper_league_id, @user.id)

        expect(user_sleeper_league).to be_a(UserSleeperLeague)
        expect(user_sleeper_league.sleeper_league_id).to eq(@sleeper_league_id)
        expect(user_sleeper_league.sleeper_league_name).to eq("Dynasty Daddies")
        expect(@user.user_sleeper_leagues).to eq([user_sleeper_league])
      end
    end

    describe '.get_sleeper_league_name(sleeper_league_id)' do
      it 'gets the sleeper league name from the sleeper api' do
        result = UserSleeperLeague.get_sleeper_league_name(@sleeper_league_id)

        expect(result).to eq("Dynasty Daddies")
      end
    end
  end
end