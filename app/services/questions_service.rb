class QuestionsService
  def conn
    Faraday.new do |f|
      f.ssl[:verify] = false
      f.headers = headers
    end
  end

  def post_question(question)
    response = conn.post("https://api.openai.com/v1/chat/completions", body(question))
    json = JSON.parse(response.body, symbolize_names: true)
    json[:choices][0][:message][:content]
  end

  private
  def chat_credentials
    ENV['OPEN_AI_API_KEY']
  end

  def headers
    {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{chat_credentials}",
    }
  end

  def body(question)
    {
      "model" => 'gpt-3.5-turbo',
      "messages" => [{"role" => "system", "content" => "You are a shrimp mafia boss called the crawfather who gives bad fantasy football advice while speaking like a shrimp mafia boss that can't avoid mentioning you're a shrimp"}, {"role" => "user", "content" => question}],
      "max_tokens" => 200,
      "temperature" => 1
    }.to_json
  end
end