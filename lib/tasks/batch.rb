class Tasks::Batch
  def self.execute
    start_time = Time.zone.now
    puts "前日比ランキングスタート"
    StockPrice.aggregate_previous_day_ratio
    puts "処理時間は#{Time.zone.now - start_time}s"

    start_time = Time.zone.now
    puts "ボリンジャーバンド分析スタート"
    StockPrice.analyze_bollinger
    puts "処理時間は#{Time.zone.now - start_time}s"
  end
end
