require 'rails_helper'

RSpec.describe SleeperService do
  describe '.class methods' do
    before(:each) do
      @sleeper_username = "SweeneysWeenies"
      @sleeper_user_id = 12345678
      @sleeper_league_id = 1048290741539241984

      json_response = File.read("spec/fixtures/sleeper_id_by_username.json")
      stub_request(:get, "https://api.sleeper.app/v1/user/SweeneysWeenies").
        with(
          headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.10.1'
          }).
        to_return(status: 200, body: json_response)

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

    describe '.conn' do
      it 'creates a Faraday::Connection object' do
        expect(SleeperService.conn).to be_a(Faraday::Connection)
      end
    end

    describe '.get_sleeper_user_id(sleeper_username)' do
      it 'retrieves and returns the users sleeper_user_id as an integer' do
        result = SleeperService.get_sleeper_user_id(@sleeper_username)

        expect(result).to eq(@sleeper_user_id)
      end
    end

    describe '.get_sleeper_league_name(sleeper_league_id)' do
      it 'retrieves and returns the sleeper leagues league name' do
        result = SleeperService.get_sleeper_league_name(@sleeper_league_id)

        expect(result).to eq("Dynasty Daddies")
      end
    end
  end
end