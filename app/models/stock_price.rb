# == Schema Information
#
# Table name: stock_prices
#
#  id          :integer          not null, primary key
#  target_date :date             not null
#  code        :integer          not null
#  market_id   :integer          not null
#  open        :integer          not null
#  high        :integer          not null
#  low         :integer          not null
#  close       :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class StockPrice < ActiveRecord::Base
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
        # コメント行は初回時に必要 ないと速度早い
        #brand = Brand.find_by(code: d[0].match(/\d*/)[0])
        #if brand.blank?
        #  Brand.create(name: d[1], code: d[0].match(/\d*/)[0].to_i)
        #end
        # 新しい方法 これなら１行で済む
        # Brand.where(code: d[0].match(/\d*/)[0]).find_or_create
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
  end
end
