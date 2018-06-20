class HistoryExporter
  def initialize(channel)
    @channel = channel
  end

  def perform!
    # Not yet implemented
    export

  rescue => e
    SlackPlayground.logger.error("Caught exception: #{e.class}, channel_id: #{@channel.id}, channel_name: #{@channel.name}", with_put: true)
    SlackPlayground.logger.error(e.message, with_put: true)

    e.backtrace.each do |row|
      SlackPlayground.logger.error(row)
    end
  end

  private

  def export
    response = fetch

    if response.ok?
      FileUtils.mkdir_p(File.dirname(file_path))

      File.open(file_path, 'w') do |file|
        file.write(response.to_yaml)
      end
    else
      fail "Fetch Error, error: #{response.error}"
    end
  end

  def fetch
    client.channels_history(channel: @channel.id)
  end

  def file_path
    File.join(SlackPlayground::CHANNELS_DIR, @channel.id, 'history.yml')
  end

  def client
    @client ||= ::Slack::Web::Client.new
  end
end
