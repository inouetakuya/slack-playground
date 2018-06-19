describe Channel do
  describe '.fetch_by_name' do
    let(:channel_name) { 'livesense-engineers' }

    it 'Channel を取得できる' do
      channel = Channel.fetch_by_name(channel_name)
      expect(channel.id).to match /\AC/
      expect(channel.name).to eq channel_name
    end
  end
end
