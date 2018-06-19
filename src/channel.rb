class Channel
  class << self
    def fetch_by_name(name)
      response = client.channels_info(channel: Channel.hash_name_from(name))
      Channel.new(response['channel'])
    end

    def hash_name_from(name)
      name.match(/\A#/) ? name : "##{name}"
    end

    private

    def client
      @client ||= ::Slack::Web::Client.new
    end
  end

  def initialize(info)
    @info = info
  end

  def id
    @info['id']
  end

  def name
    @info['name']
  end

  def hash_name
    '#' + name
  end
end
