class VisualizeController < ApplicationController
  def index
    @graph_data = [[201_305, 9_283_492], [201_306, 4_095_925], [201_307, 11_042_345]]
    render layout: "visualize"
  end
end
