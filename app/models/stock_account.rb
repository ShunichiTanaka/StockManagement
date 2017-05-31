# == Schema Information
#
# Table name: stock_accounts
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  stock_company_id :integer          not null
#  assets_sum       :integer          default("0"), not null
#  info             :text(65535)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class StockAccount < ActiveRecord::Base
end
