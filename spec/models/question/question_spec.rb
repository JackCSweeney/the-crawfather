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

  it 'can attatch an image of its question to itself' do
    user = User.create!({name: "test", email: "test@email.com", password: "password", password_confirmation: "password", roundup_status: 1})
    create(:question, user_id: user.id)

    question = user.questions[0]

    question.make_response_image

    expect(question.image.attached?).to eq(true)
  end
end