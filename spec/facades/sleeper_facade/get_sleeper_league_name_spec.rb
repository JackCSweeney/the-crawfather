require 'rails_helper'

RSpec.describe SleeperFacade do
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
    describe '.get_sleeper_league_name(sleeper_league_id)' do
      it 'gets the sleeper leagues name from the sleeper_league_id' do
        result = SleeperFacade.get_sleeper_league_name(@sleeper_league_id)

        expect(result).to eq("Dynasty Daddies")
      end
    end
  end
end