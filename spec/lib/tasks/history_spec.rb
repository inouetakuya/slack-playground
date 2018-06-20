describe Task::History do
  describe '#export' do
    after do
      FileUtils.rm_rf(Dir[File.join(SlackPlayground::CHANNELS_DIR, '*')])
    end

    it 'Channel の発言履歴を YAML ファイルとして保存する' do
      expect {
        Task::History.new.invoke(:export, [], channel: 'eng-board', force: true)
      }.to change { Dir[File.join(SlackPlayground::CHANNELS_DIR, '**/history_*.yml')].size }
    end
  end
end
