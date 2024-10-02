require 'rails_helper'

RSpec.describe UserSleeperAccount do
  describe 'Validations' do
    it { should validate_presence_of(:sleeper_username) }
    it { should validate_presence_of(:sleeper_user_id) }
    it { should validate_presence_of(:user_id) }
    it { should belong_to :user }
  end
end