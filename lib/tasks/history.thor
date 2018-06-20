require 'thor'

module Task
  class History < Thor
    desc 'stats', 'Stats of the history'
    def stats
      result = {}

      Dir[File.join(SlackPlayground::CHANNELS_DIR, '**/history_*.yml')].each do |history_yaml_path|
        history = YAML.load_file(history_yaml_path)
        history.messages.each do |message|
          next if message.username == 'unknown'
          next if message.text.blank?

          m = ::Message.new(message)

          if result[m.ym]
            if m.reaction?
              result[m.ym][:reaction] += 1
            else
              result[m.ym][:message] += 1
              result[m.ym][:reaction] += m.reactions_count
            end
          else
            result[m.ym] = { message: 0, reaction: 0 }
          end
        end
      end

      result.sort.each do |ym, count|
        puts "#{ym} => { message: #{count[:message]}, reaction: #{count[:reaction]}, sum: #{count[:message] + count[:reaction]} }"
      end
    end

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
