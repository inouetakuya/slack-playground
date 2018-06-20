describe Task::Channel do
  describe '#history' do
    after do
      FileUtils.rm_rf(Dir[File.join(SlackPlayground::CHANNELS_DIR, '*')])
    end

    it 'Channel の発言履歴を YAML ファイルとして保存する' do
      expect {
        Task::Channel.new.invoke(:history, [], channel: 'livesense-engineers', force: true)
      }.to change { Dir[File.join(SlackPlayground::CHANNELS_DIR, '**/history_*.yml')].size }
    end
  end
end
