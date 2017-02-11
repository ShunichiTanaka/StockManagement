class GoogleChart
  def initialize
    @data_table = GoogleVisualr::DataTable.new
  end

  def line_chart(data, flag)
  	line_types
  	case flag
    when true
      data.each_with_index do |d, count|
        @data_table.set_cell(count, 0, d["date"].to_s)
        @data_table.set_cell(count, 1, d["close"])
        @data_table.set_cell(count, 2, d["high"])
      end
    when false
      data.each_with_index do |d, count|
        @data_table.set_cell(count, 0, d["date"].to_s)
        @data_table.set_cell(count, 1, d["close_price"])
        @data_table.set_cell(count, 2, d["high_price"])
      end
    end
    opts = { :width => 550, :height => 400, :legend => 'bottom' }
    chart = GoogleVisualr::Interactive::LineChart.new(@data_table, opts)
  end

  private

  def line_types
    @data_table.add_rows(150)
    @data_table.new_column('string', 'Year')
    @data_table.new_column('number', 'Closed')
    @data_table.new_column('number', 'High')
  end
end
