require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:question) }
    it { should validate_presence_of(:response) }
    it { should validate_presence_of(:user_id) }
  end

  describe 'relationships' do
    it {should belong_to :user}
  end
end