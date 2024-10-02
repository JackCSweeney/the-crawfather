require 'rails_helper'

RSpec.describe SleeperService do
  describe '.class methods' do
    before(:each) do
      @sleeper_username = "SweeneysWeenies"
      @sleeper_user_id = 12345678
      json_response = File.read("spec/fixtures/sleeper_id_by_username.json")

      stub_request(:get, "https://api.sleeper.app/user/SweeneysWeenies").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.10.1'
           }).
         to_return(status: 200, body: json_response)
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
  end
end