describe HistoryExporter do
  let(:exporter) { HistoryExporter.new(channel)}
  let(:channel) { Channel.fetch_by_name('livesense-engineers') }

  describe '#perform!' do
    it 'Channel の発言を YAML ファイルとして保存する'
  end

  describe '#export' do
    after do
      FileUtils.rm_rf(Dir[File.join(SlackPlayground::CHANNELS_DIR, '*')])
    end

    it 'history を YAML ファイルに出力する' do
      expect {
        exporter.send(:export)
      }.to change { Dir[File.join(SlackPlayground::CHANNELS_DIR, '**/history.yml')].size }
    end
  end

  describe '#fetch' do
    it 'Channel の発言を取得できる' do
      response = exporter.send(:fetch)
      expect(response.ok).to be_truthy
    end
  end
end
