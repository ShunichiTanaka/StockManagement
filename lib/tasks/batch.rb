class Tasks::Batch
  def self.execute
    StockPrice.aggregate_previous_day_ratio
  end
end
