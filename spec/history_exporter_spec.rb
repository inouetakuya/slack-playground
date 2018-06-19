describe HistoryExporter do
  let(:exporter) { HistoryExporter.new(channel)}
  let(:channel) { Channel.fetch_by_name('livesense-engineers') }

  describe '#perform!' do
    it 'Channel の発言を YAML ファイルとして保存する'
  end

  describe '#fetch' do
    it 'Channel の発言を取得できる' do
      response = exporter.fetch
      expect(response.ok).to be_truthy
    end
  end
end
