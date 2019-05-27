class Banner
  def initialize(message)
    @message = message
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def get_message_length
    @message.length + 2
  end

  def horizontal_rule
    "+" + "-" * get_message_length + "+"
  end

  def empty_line
    "|" + " " * get_message_length + "|"
  end

  def message_line
    "| #{@message} |"
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner