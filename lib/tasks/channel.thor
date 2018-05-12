require 'thor'

module Task
  class Channel < Thor
    desc 'history', 'Show channel history'
    method_option :channel, type: :string, desc: 'Channel name', required: true
    def history
      channel_name = options[:channel].match(/\A#/) ? options[:channel] : "##{options[:channel]}"
      client = ::Slack::Web::Client.new
      client.channels_history(channel: channel_name)
    end
  end
end
