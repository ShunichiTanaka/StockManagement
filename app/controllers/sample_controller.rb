class SampleController < ApplicationController
  before_action :display_chart, only: [:index]

  def index
  end

  def display_chart
    quand = Quandls.new
    quand.quandl_client
    nikkei_data, jasdaq_data = quand.receive_info
    google_chart_nikkei = GoogleChart.new
    @nikkei_average = google_chart_nikkei.line_chart(nikkei_data.reverse, false)
    google_chart_jasdaq = GoogleChart.new
    @jasdaq_average = google_chart_jasdaq.line_chart(jasdaq_data.reverse, true)
  end
end
