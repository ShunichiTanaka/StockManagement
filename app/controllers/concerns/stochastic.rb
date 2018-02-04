module Stochastic
  extend ActiveSupport::Concern

  # %Dの設定値は5固定
  D_SET = 5
  # データは9日分(5 + 4)必要
  D_VALUE = 9

  def calc_stochastic(code, range)
    close_arr = StockPrice.closing_prices(code, range)
    calced_arr = []
    [*(0..4)].each do |num|
      calc_target_arr = close_arr[num..(num+4)]
      calced_arr << calc_k(calc_target_arr) if check_arr_size?(calc_target_arr)
    end
    calc_d(calced_arr)
  end

  # 抽出対象
  # 一般的に%Dが70以上で買われすぎ
  # 30%以下が売られすぎの状態
  def target_stochastic(d, pre_d)
    return false if d.blank?
    return false if pre_d.blank?
    return false if d > 20
    return false if pre_d - d < 5
    true
  end

  private

  # %Kの算出
  def calc_k(close_arr)
    return 0 if (close_arr.max - close_arr.min).zero?
    (close_arr.last - close_arr.min).to_f / (close_arr.max - close_arr.min).to_f * 100
  end

  # %Dの算出
  def calc_d(arr)
    arr.sum.to_f / D_SET if arr.length == D_SET
  end

  def check_arr_size?(calc_arr)
    return false if calc_arr.blank?
    return false if calc_arr.length != D_SET
    true
  end
end
