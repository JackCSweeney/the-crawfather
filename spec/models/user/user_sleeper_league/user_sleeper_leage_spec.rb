require 'rails_helper'

RSpec.describe UserSleeperLeague do
  describe 'validations' do
    it { should validate_presence_of(:league_name) }
    it { should validate_presence_of(:sleeper_league_id) }
    it { should validate_numericality_of(:sleeper_league_id) }
    it { should belong_to :user }
  end
end