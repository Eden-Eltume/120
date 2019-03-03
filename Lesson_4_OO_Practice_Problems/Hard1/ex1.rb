class SecretFile
  def initialize(secret_data, logger)
    @data = secret_data
    @logger = logger
  end

  def data
    @logger.create_log_entry
   #@data #Comment this code to reveal the secret timestamp
  end
end


class SecurityLogger
  def create_log_entry
    timestamp = []
    timestamp << Time.now
    timestamp
  end
end

log_entry1 = SecurityLogger.new

classified = SecretFile.new("secret data", log_entry1)

puts classified.data
