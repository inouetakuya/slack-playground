describe HistoryExporter do
  let(:exporter) { HistoryExporter.new(channel) }
  let(:channel) { Channel.fetch_by_name('eng-board') }

  describe '#perform!' do
    after do
      FileUtils.rm_rf(Dir[File.join(SlackPlayground::CHANNELS_DIR, '*')])
    end

    it 'Channel の発言履歴を YAML ファイルとして保存する' do
      expect {
        exporter.perform!
      }.to change { Dir[File.join(SlackPlayground::CHANNELS_DIR, '**/history_*.yml')].size }
    end
  end

  describe '#export' do
    after do
      FileUtils.rm_rf(Dir[File.join(SlackPlayground::CHANNELS_DIR, '*')])
    end

    it 'Channel の発言履歴を YAML ファイルに出力する' do
      expect {
        exporter.send(:export, latest: nil)
      }.to change { Dir[File.join(SlackPlayground::CHANNELS_DIR, '**/history_*.yml')].size }
    end
  end

  describe '#fetch' do
    it 'Channel の発言履歴を取得できる' do
      response = exporter.send(:fetch, latest: nil)
      expect(response.ok?).to be_truthy
    end
  end
end
