FactoryBot.define do
  factory :question do
    question { "Question" }
    response { "Response" }
    user_id { 1 }
  end
end
