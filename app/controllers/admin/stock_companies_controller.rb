class Admin::StockCompaniesController < ApplicationController
	before_action :set_stock_company, only: [:create]

	def new
		@stock_company = StockCompany.new
	end

	def create
		if @stock_company.save
			flash[:notice] = 'create new stock company'
		  return render "sample/index"
	  else
			flash[:alert] = @stock_company.errors.messages
		  return redirect_to action: :new
		end
	end

	private

	def set_stock_company
		@stock_company = StockCompany.new(params.require(:stock_company).permit(:name, :info))
	end
end
