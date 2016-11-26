class VisualizeController < ApplicationController
	def index
		@graph_data = [[201305, 9283492], [201306,4095925], [201307,11042345]]
		render :layout => 'visualize'
	end
end
