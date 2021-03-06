require 'thor'

module Task
  class History < Thor
    desc 'export', 'Export the history of channel to YAML files'
    method_option :channel, type: :string, desc: 'Channel name', required: true
    method_option :force, type: :boolean, default: false, desc: 'Skip asking questions'
    def export
      unless options[:force] || yes?("Export the history of channel to YAML files? (y/N)", :yellow)
        return say 'Task is aborted'
      end

      channel = ::Channel.fetch_by_name(options[:channel])
      exporter = HistoryExporter.new(channel)
      exporter.perform!

      say "History of channel (#{options[:channel]}) is exported successfully"
    end

    desc 'clear', 'Remove channel history YAML files'
    method_option :force, type: :boolean, default: false, desc: 'Skip asking questions'
    def clear
      unless options[:force] || yes?("Remove channel history YAML files? (y/N)", :yellow)
        return say 'Task is aborted'
      end

      FileUtils.rm_rf(SlackPlayground::CHANNELS_DIR) if File.exist?(SlackPlayground::CHANNELS_DIR)
      say 'Channel history YAML files are removed'
    end
  end
end
