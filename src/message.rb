class Message
  def initialize(message)
    @message = message
  end

  def reaction?
    @message.text.match /\A\(\w+\)\z/
  end

  def reactions
    @message.reactions
  end

  def reactions_count
    if @message.reactions
      @message.reactions.inject(0) { |sum, reaction|
        sum += reaction.count
      }
    else
      0
    end
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
