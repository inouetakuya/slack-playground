class Channel
  class << self
    def fetch_by_name(name)
      response = client.channels_info(channel: Channel.hash_name_from(name))
      response['channel']
    end

    def hash_name_from(name)
      name.match(/\A#/) ? name : "##{name}"
    end

    private

    def client
      @client ||= ::Slack::Web::Client.new
    end
  end
end
