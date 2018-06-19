require 'thor'

module Task
  class Channel < Thor
    desc 'history', 'Show channel history'
    method_option :channel, type: :string, desc: 'Channel name', required: true

    def history
      channel = ::Channel.fetch_by_name(options[:channel])
      exporter = HistoryExporter.new(channel)
      exporter.perform!
    end
  end
end
