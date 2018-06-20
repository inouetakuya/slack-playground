class Message
  def initialize(message)
    @message = message
  end

  def reaction?
    @message.text.match /\A\(\w+\)\z/
  end

  def timestamp
    @message.ts.split('.')[0].to_i
  end

  def time
    Time.at(timestamp)
  end

  def ym
    time.strftime('%Y-%m')
  end
end
