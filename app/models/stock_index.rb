# == Schema Information
#
# Table name: stock_indices
#
#  id             :integer          not null, primary key
#  target_date    :date             not null
#  nikkei         :float(24)        not null
#  topix          :float(24)        not null
#  mothers        :float(24)        not null
#  jasdaq         :float(24)        not null
#  two_department :float(24)        not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class StockIndex < ActiveRecord::Base
end
