class SampleController < ApplicationController
  before_action :display_chart, only: [:index]

  def index
  end

  def display_chart
    quandls = Quandls.new
    quandls.quandl_client
    nikkei_data, jasdaq_data = quandls.receive_info
    nikkei = GoogleChart.new
    @nikkei_average = nikkei.line_chart(nikkei_data.reverse, false)
    jasdaq = GoogleChart.new
    @jasdaq_average = jasdaq.line_chart(jasdaq_data.reverse, true)
  end
end
