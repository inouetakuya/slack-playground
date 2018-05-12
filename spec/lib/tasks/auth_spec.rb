describe Task::Auth do
  describe '#test' do
    it '正常終了する' do
      expect {
        Task::Auth.new.invoke(:test)
      }.not_to raise_error
    end
  end
end
