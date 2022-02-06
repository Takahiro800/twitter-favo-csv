require "pp"
require "twitter"
require "pry"
require "date"
require "csv"

client = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV['API_KEY']
  config.consumer_secret = ENV['API_SECRET']
  config.access_token = ENV['ACCESS_TOKEN']
  config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
end

date = Date.today.to_s
file_name = date + '.csv'

favs = client.favorites({count: 200})
# favs = client.favorites

CSV.open(file_name, 'w') do |data|
  data << ["tweet_id", "tweet_uri", "tweet_text", "user_id", "user_name", "user_icon"]
  for tw in favs do
    data << [tw.id, tw.uri, tw.full_text, tw.user.id, tw.user.name, tw.user.profile_image_url_https]
  end
end

# pp arr_favorites.count
# pp arr_favorites[0]
