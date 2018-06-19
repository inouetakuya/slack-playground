class HistoryExporter
  def initialize(channel)
    @channel = channel
  end

  def perform!
    # Not yet implemented
  end

  def fetch
    client.channels_history(channel: @channel.hash_name)
  end

  private

  def client
    @client ||= ::Slack::Web::Client.new
  end
end
