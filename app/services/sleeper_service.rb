class SleeperService
  def self.get_sleeper_user_id(sleeper_username)
    response = conn.get("/v1/user/#{sleeper_username}")
    JSON.parse(response.body, symbolize_names: true)[:user_id].to_i
  end

  def self.conn
    Faraday.new(url: "https://api.sleeper.app")
  end
end