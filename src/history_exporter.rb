class HistoryExporter
  def initialize(channel)
    @channel = channel
  end

  def perform!
    response = { 'messages' => [{ ts: nil }] }

    loop do
      response = export(latest: response['messages'][-1]['ts'])
      break unless response.has_more?
    end

  rescue => e
    SlackPlayground.logger.error("Caught exception: #{e.class}, channel_id: #{@channel.id}, channel_name: #{@channel.name}", with_put: true)
    SlackPlayground.logger.error(e.message, with_put: true)

    e.backtrace.each do |row|
      SlackPlayground.logger.error(row)
    end
  end

  private

  def export(latest:)
    response = fetch(latest: latest)
    path = file_path(latest)

    if response.ok?
      FileUtils.mkdir_p(File.dirname(path))

      File.open(path, 'w') do |file|
        file.write(response.to_yaml)
      end
    else
      fail "Fetch Error, error: #{response.error}"
    end

    response
  end

  def fetch(latest:)
    client.channels_history(
      channel: @channel.id,
      count: 1000,
      inclusive: false,
      latest: latest, unreads: false,
    )
  end

  def file_path(latest)
    if latest
      File.join(SlackPlayground::CHANNELS_DIR, @channel.id, "history_#{latest}.yml")
    else
      File.join(SlackPlayground::CHANNELS_DIR, @channel.id, 'history_now.yml')
    end
  end

  def client
    @client ||= ::Slack::Web::Client.new
  end
end
