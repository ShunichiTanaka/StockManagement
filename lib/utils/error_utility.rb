class ErrorUtility
  def self.log_and_notify(e)
    Rails.logger.error e.message
    Rails.logger.error e.backtrace.join("\n")
  end
end
