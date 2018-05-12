require 'thor'

module Task
  class Auth < Thor
    desc 'test', 'Authentication test for Slack API'
    def test
      client = ::Slack::Web::Client.new
      result = client.auth_test
      puts result

    rescue Slack::Web::Api::Errors::SlackError => e
      puts "Slack::Web::Api::Errors::SlackError: #{e.message}"
    end
  end
end
