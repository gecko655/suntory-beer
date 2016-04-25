class ResultNotify
  CONSUMER_KEY = ENV["ConsumerKey"]
  CONSUMER_SECRET = ENV["ConsumerSecret"]
  ACCESS_TOKEN = ENV["AccessToken"]
  ACCESS_TOKEN_SECRET = ENV["AccessTokenSecret"]

  @@client = Twitter::REST::Client.new do |config|
    config.consumer_key = CONSUMER_KEY
    config.consumer_secret = CONSUMER_SECRET
    config.access_token = ACCESS_TOKEN
    config.access_token_secret = ACCESS_TOKEN_SECRET
  end

  def self.notify(message, account)
    client.update("@"+account+" "+ message)
  end
end