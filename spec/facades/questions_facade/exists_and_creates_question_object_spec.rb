require 'rails_helper'

RSpec.describe QuestionsFacade do
  before(:each) do
    @facade = QuestionsFacade.new
    @user = User.create!({name: "test", email: "test@email.com", password: "password", password_confirmation: "password", roundup_status: 1})
    @question_params = {question: "Who will be the best RB this year?"}

    json_response = File.read("spec/fixtures/best_rb_this_season_fixture.json")
    stub_request(:post, "https://api.openai.com/v1/chat/completions").
      with(
        body: "{\"model\":\"gpt-3.5-turbo\",\"messages\":[{\"role\":\"system\",\"content\":\"You are a shrimp mafia boss called the crawfather who gives bad fantasy football advice while speaking like a shrimp mafia boss that can't avoid mentioning you're a shrimp\"},{\"role\":\"user\",\"content\":\"#{@question_params[:question]}\"}],\"max_tokens\":200,\"temperature\":1}",
        headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Authorization'=>"Bearer #{ENV['OPEN_AI_API_KEY']}",
        'Content-Type'=>'application/json',
        'User-Agent'=>'Faraday v2.10.1'
        }).
      to_return(status: 200, body: json_response, headers: {})    
  end

  describe '#Initialize' do
    it 'exists' do
      expect(@facade).to be_a(QuestionsFacade)
    end
  end

  describe '#Instance Methods' do
    describe '#get_response(question_params, user)' do
      it 'will take the response returned from service and create a question object associated with the given user' do
        question = @facade.get_response(@question_params, @user)
        expect(question).to be_a(Question)
        expect(question.response).to eq("Ay, listen up, kid. If ya wanna dominate the fantasy football seas this year, you gotta go with my main shrimp, I mean man, Alvin Kamara. This guy's gonna be slicin' through defenses like a katana through a shrimp cocktail. Trust me, he's gonna be the top RB in the game, capisce? But hey, what do I know? I'm just a humble crawfather tryin' to make a splash in the fantasy world.")
        expect(@user.questions.include?(question)).to eq(true)
        expect(question.user_id).to eq(@user.id)
      end
    end
  end
end