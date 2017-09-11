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
#  tag            :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class TradingHistory < ActiveRecord::Base
  has_many :tags, through: :trade_tags
  has_many :trade_tags
  belongs_to :brand, foreign_key: "code", primary_key: "code"

  accepts_nested_attributes_for :trade_tags, allow_destroy: true

  # attr_accessor :name
  attr_accessor :tag_ids

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

  def save_tags
    old_tags = tags.pluck(:tag_id).map(&:to_s)
    new_tags = tag_ids if tag_ids.present?
    current_tags = new_tags - old_tags if new_tags
    old_tags = old_tags - new_tags if new_tags
    current_tags.each do |current_tag|
      TradeTag.create(trading_history_id: id, tag_id: current_tag)
    end
    old_tags.each do |old_tag|
      TradeTag.where(trading_history_id: id, tag_id: old_tag).destroy_all
    end
  end
end
