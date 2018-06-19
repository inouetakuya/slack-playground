class HistoryExporter
  def initialize(channel)
    @channel = channel
  end

  def perform!
    # Not yet implemented
    export
  end

  private

  def export
    response = fetch

    FileUtils.mkdir_p(File.dirname(file_path))

    File.open(file_path, 'w') do |file|
      file.write(response.to_yaml)
    end
  end

  def fetch
    client.channels_history(channel: @channel.hash_name)
  end

  def file_path
    File.join(SlackPlayground::CHANNELS_DIR, @channel.id, 'history.yml')
  end

  def client
    @client ||= ::Slack::Web::Client.new
  end
end
