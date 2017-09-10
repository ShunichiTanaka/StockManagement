# == Schema Information
#
# Table name: trade_tags
#
#  id                 :integer          not null, primary key
#  trading_history_id :integer
#  tag_id             :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class TradeTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :trading_history
end
