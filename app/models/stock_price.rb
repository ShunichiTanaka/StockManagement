# == Schema Information
#
# Table name: stock_prices
#
#  id                   :integer          not null, primary key
#  target_date          :date             not null
#  code                 :integer          not null
#  market_id            :integer          not null
#  open                 :integer          not null
#  high                 :integer          not null
#  low                  :integer          not null
#  close                :integer          not null
#  trading_value        :integer          not null
#  previous_price       :integer
#  previous_price_ratio :float(24)
#  twenty_average       :float(24)
#  standard_deviation   :float(24)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class StockPrice < ActiveRecord::Base
  belongs_to :brand, foreign_key: "code", primary_key: "code"

  attr_accessor :ratio

  scope :from_current_day, lambda { |days|
    group(:target_date)
      .order("target_date DESC")
      .limit(days)
      .pluck(:target_date)
  }
  scope :from_previous_day, lambda { |days|
    group(:target_date)
      .order("target_date DESC")
      .limit(days)
      .offset(1)
      .pluck(:target_date)
  }
  scope :summary, lambda { |range|
    where(target_date: range)
      .group(:code)
      .average(:close)
  }
  scope :closing_prices, lambda { |code, range|
    where(target_date: range)
      .where(code: code)
      .pluck(:close)
  }
  scope :target_summary, lambda { |code, range|
    where(target_date: range)
      .where(code: code)
      .average(:close)
  }

  class << self
    def data_import(data, target_date)
      data.each do |d|
        next if d.include?(nil)
        # brand = Brand.find_by(code: d[0].match(/\d*/)[0])
        # if brand.blank?
        #   Brand.create(name: d[1], code: d[0].match(/\d*/)[0].to_i)
        # end
        #  Brand.where(code: d[0].match(/\d*/)[0]).find_or_create
        market = Market.find_by(name: d[2])
        new_market = Market.create(name: d[2]) if market.blank?
        StockPrice.create(
          target_date: target_date,
          code: d[0].match(/\d*/)[0],
          market_id: select_market(market, new_market),
          open: d[3], high: d[4], low: d[5], close: d[6], trading_value: d[8]
        )
      end
    end

    def select_market(market, new_market)
      return market.id if new_market.blank?
      new_market.id
    end

    def summary_brand(code)
      target_range = StockPrice.from_current_day(31).reverse
      date_data = target_range.map { |d| d.strftime("%m/%d") }
      summaries = where(code: code, target_date: target_range)
                  .order("target_date desc").pluck(:close).reverse

      {
        labels: date_data,
        datasets: generate_chart_js_options(summaries)
      }
    end

    def generate_chart_js_options(summaries)
      [{
        fill: false,
        lineTension: false,
        backgroundColor: "rgba(255, 92, 132, 0.8)",
        borderColor: "rgba(255, 92, 132, 0.8)",
        borderWidth: 4,
        borderJoinStyle: "round",
        borderCapStyle: "butt",
        pointBorderColor: "rgba(255, 92, 132, 0.8)",
        pointBackgroundColor: "#fff",
        pointBorderWidth: 1,
        pointHoverRadius: 3,
        pointHoverBackgroundColor: "rgba(255, 92, 132, 0.8)",
        pointHoverBorderColor: "rgba(255, 92, 132, 0.8)",
        pointHoverBorderWidth: 3,
        pointRadius: 4,
        pointHitRadius: 10,
        data: summaries
      }]
    end

    def aggregate_previous_day_ratio
      today_stock_summary = where(target_date: from_current_day(1))
      yesterday_stock_summary = where(target_date: from_previous_day(1))
      brands = Brand.all
      brands.each do |brand|
        target_brand = today_stock_summary.find_by(code: brand.code)
        yesterday_target_brand = yesterday_stock_summary.find_by(code: brand.code)
        if target_brand.present? && target_brand.close.present? && yesterday_target_brand.present? && yesterday_target_brand.close.present?
          previous_price = target_brand.close - yesterday_target_brand.close
          previous_price_ratio = (target_brand.close.to_f / yesterday_target_brand.close.to_f - 1) * 100
          target_brand.update(
            previous_price: previous_price,
            previous_price_ratio: previous_price_ratio
          )
        end
      end
    end

    def analyze_bollinger
      # ボリンジャーバンド設定値
      n = 20
      long_target_range = from_current_day(n)
      bollinger_data = []
      brands = Brand.all
      brands.each do |brand|
        close_arr = closing_prices(brand.code, long_target_range)
        if close_arr.count != n
          next
        else
          # 平均
          mean = close_arr.sum.to_f / n
          # 偏差平方和
          sum_of_squares = close_arr.inject(0) { |sum, i| sum + (i - mean)**2 }
          # 分散
          distributed = sum_of_squares / n
          # 標準偏差
          s = Math.sqrt(distributed)
          # n日の移動平均
          n_average = target_summary(brand.code, long_target_range)
          # 2αのボリンジャーバンド
          res_2 = n_average.to_f + (s * 2)
          # 3αのボリンジャーバンド
          res_3 = n_average.to_f + (s * 3)
          # 当日の株価
          target_stock = where(target_date: from_current_day(1), code: brand.code).first

          target_stock.update(twenty_average: n_average, standard_deviation: s)
          if target_stock.high >= res_2 && target_stock.low < res_2 && res_2 > 350 && res_2 < 2500 && target_stock.close >= target_stock.open && res_3 >= target_stock.high.to_f
            bollinger_data << { code: brand.code, name: brand.name, close: target_stock.close }
          end
        end
      end
      StockMailer.send_bollinger_data(bollinger_data).deliver
    end
  end
end
