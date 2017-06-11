# == Schema Information
#
# Table name: trading_histories
#
#  id             :integer          not null, primary key
#  purchase_date  :date             not null
#  code           :integer          not null
#  purchase_price :integer          not null
#  stock_number   :integer          not null
#  disposal_date  :date
#  disposal_price :integer
#  profit         :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class TradingHistory < ActiveRecord::Base
  belongs_to :brand, foreign_key: "code", primary_key: "code"

  attr_accessor :name

  validates :purchase_date, presence: true
  validates :code, presence: true, numericality: :only_integer
  validates :purchase_price, presence: true, numericality: :only_integer
  validates :stock_number, presence: true, numericality: :only_integer

  scope :current_month_profit, -> {
    where("DATE_FORMAT(disposal_date, '%Y%m') = DATE_FORMAT(NOW(), '%Y%m')")
      .sum(:profit).to_s(:delimited)
  }
  scope :current_week_profit, -> {
    where(disposal_date: [5.days.ago..Date.current])
      .sum(:profit).to_s(:delimited)
  }
end
