describe Task::Channel do
  describe '#history' do
    after do
      FileUtils.rm_rf(Dir[File.join(SlackPlayground::CHANNELS_DIR, '*')])
    end

    it '正常終了する' do
      expect {
        Task::Channel.new.invoke(:history, [], channel: '#livesense-engineers')
      }.not_to raise_error
    end
  end
end
