require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:credits) }
    it { should validate_numericality_of(:credits) }
  end

  describe 'enums' do
    it { should define_enum_for(:roundup_status).with_values(["enabled", "disabled"]) }
  end

  describe 'relationships' do
    it {should have_many :questions}
  end

end