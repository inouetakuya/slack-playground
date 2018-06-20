require 'active_support'
require 'active_support/core_ext'
require 'dotenv/load'
require 'pry'
require 'slack-ruby-client'
require 'yaml'

module SlackPlayground
  ROOT_PATH = File.expand_path('../', __dir__)

  CHANNELS_DIR =
    if ENV['ENV'] == 'test'
      File.join(SlackPlayground::ROOT_PATH, 'spec/tmp/channels')
    else
      File.join(SlackPlayground::ROOT_PATH, 'tmp/channels')
    end
end

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
end

Dir[
  File.join(__dir__, '../lib/**/*.rb'),
  File.join(__dir__, '../src/**/*.rb'),
].each do |file|
  require file
end

Dir[
  File.join(__dir__, '../lib/tasks/**/*.thor'),
].each do |file|
  load file
end
