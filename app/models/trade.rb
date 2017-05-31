# == Schema Information
#
# Table name: trades
#
#  id               :integer          not null, primary key
#  stock_account_id :integer          not null
#  brand_id         :integer          not null
#  status           :integer          not null
#  trade_at         :date             default("0000-00-00"), not null
#  contract_price   :integer          not null
#  trade_sum        :integer          not null
#  sales_price      :integer          not null
#  charges          :integer          not null
#  payment_at       :date
#  payment_price    :integer
#  profit_ratio     :float(24)
#  info             :text(65535)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Trade < ActiveRecord::Base
end
