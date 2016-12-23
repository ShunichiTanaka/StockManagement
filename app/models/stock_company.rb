class StockCompany < ActiveRecord::Base
	validates :name, presence: true
end
