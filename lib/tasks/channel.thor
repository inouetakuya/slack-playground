require 'thor'

module Task
  class Channel < Thor
    desc 'history', 'Export the history of channel to YAML files'
    method_option :channel, type: :string, desc: 'Channel name', required: true
    method_option :force, type: :boolean, default: false, desc: 'Skip asking questions'
    def history
      unless options[:force] || yes?("Export the history of channel to YAML files? (y/N)", :yellow)
        return say 'Task is aborted'
      end

      channel = ::Channel.fetch_by_name(options[:channel])
      exporter = HistoryExporter.new(channel)
      exporter.perform!
    end
  end
end
