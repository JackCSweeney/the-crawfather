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
    it {should have_many :user_sleeper_accounts}
  end

  describe '#instance methods' do
    describe '#recent_question?' do
      it 'returns true if a users last question was created less than two minutes ago' do
        user = User.create!({name: "test", email: "test@email.com", password: "password", password_confirmation: "password", roundup_status: 1})
        user.questions.create!({question: "Hey there", response: "Nope"})

        expect(user.recent_question?).to eq(true)
      end
    end
  end
end