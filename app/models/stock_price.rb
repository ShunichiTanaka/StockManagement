# == Schema Information
#
# Table name: stock_prices
#
#  id            :integer          not null, primary key
#  target_date   :date             not null
#  code          :integer          not null
#  market_id     :integer          not null
#  open          :integer          not null
#  high          :integer          not null
#  low           :integer          not null
#  close         :integer          not null
#  trading_value :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class StockPrice < ActiveRecord::Base
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
  end
end
