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
  scope :from_current_day, lambda { |days|
    group(:target_date)
      .order("target_date DESC")
      .limit(days)
      .pluck(:target_date)
  }
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

    def summary(index_name)
      target_range = from_current_day(31).reverse
      date_data = target_range.map { |d| d.strftime("%m/%d") }
      summaries = where(target_date: target_range).pluck(index_name.to_s)

      {
        labels: date_data,
        datasets: generate_chart_js_options(summaries, index_name)
      }
    end

    def generate_chart_js_options(summaries, index_name)
      [{
        fill: false,
        lineTension: false,
        backgroundColor: Settings.color[index_name],
        borderColor: Settings.color[index_name],
        borderWidth: 4,
        borderJoinStyle: "round",
        borderCapStyle: "butt",
        pointBorderColor: Settings.color[index_name],
        pointBackgroundColor: "#fff",
        pointBorderWidth: 1,
        pointHoverRadius: 3,
        pointHoverBackgroundColor: Settings.color[index_name],
        pointHoverBorderColor: Settings.color[index_name],
        pointHoverBorderWidth: 3,
        pointRadius: 4,
        pointHitRadius: 10,
        data: summaries
      }]
    end
  end
end
