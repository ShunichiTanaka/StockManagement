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
  class << self
    def data_import(data, target_date)
      nikkei = data[1][4]
      topix = data[2][4]
      two_department = data[4][4]
      mothers = data[5][4]
      jasdaq = data[92][4]
      create(
        target_date: target_date,
        nikkei: nikkei,
        topix: topix,
        two_department: two_department,
        mothers: mothers,
        jasdaq: jasdaq
      )
    end
  end
end
