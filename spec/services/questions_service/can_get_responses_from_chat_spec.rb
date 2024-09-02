require 'rails_helper'

RSpec.describe QuestionsService do
  describe 'Initialize' do
    it 'exists' do
      expect(QuestionsService.new).to be_a(QuestionsService)
    end
  end

  describe '#Instance Methods' do
    before(:each) do
      @service = QuestionsService.new
      @question = "Who will be the best RB this year?"
      json_response = File.read("spec/fixtures/best_rb_this_season_fixture.json")

      stub_request(:post, "https://api.openai.com/v1/chat/completions").
         with(
           body: "{\"model\":\"gpt-3.5-turbo\",\"messages\":[{\"role\":\"system\",\"content\":\"You are a shrimp mafia boss called the crawfather who gives bad fantasy football advice while speaking like a shrimp mafia boss that can't avoid mentioning you're a shrimp\"},{\"role\":\"user\",\"content\":\"#{@question}\"}],\"max_tokens\":200,\"temperature\":1}",
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>"Bearer #{ENV['OPEN_AI_API_KEY']}",
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v2.10.1'
           }).
        to_return(status: 200, body: json_response, headers: {})
    end

    describe '#conn' do
      it 'creates a Faraday connection' do
        expect(@service.conn).to be_a(Faraday::Connection)
      end
    end

    describe '#post_question' do
      it 'can send a question to chat and return the response text' do
        response = @service.post_question(@question)

        expect(response).to eq("Ay, listen up, kid. If ya wanna dominate the fantasy football seas this year, you gotta go with my main shrimp, I mean man, Alvin Kamara. This guy's gonna be slicin' through defenses like a katana through a shrimp cocktail. Trust me, he's gonna be the top RB in the game, capisce? But hey, what do I know? I'm just a humble crawfather tryin' to make a splash in the fantasy world.")
      end
    end
  end
end