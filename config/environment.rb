require 'dotenv/load'
require 'pry'
require 'slack-ruby-client'

module SlackPlayground
  ROOT_PATH = File.expand_path('../', __dir__)
end

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
end

Dir[
  File.join(__dir__, '../src/**/*.rb'),
].each do |file|
  require file
end

Dir[
  File.join(__dir__, '../lib/tasks/**/*.thor'),
].each do |file|
  load file
end
