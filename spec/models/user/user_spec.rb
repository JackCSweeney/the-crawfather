require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:credits) }
    it { should validate_numericality_of(:credits) }
    it { should validate_presence_of(:roundup_status) }
  end

  describe 'relationships' do
    it {should have_many :questions}
  end

end