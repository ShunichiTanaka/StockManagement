# == Schema Information
#
# Table name: stock_companies
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  info       :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class StockCompany < ActiveRecord::Base
	validates :name, presence: true
end
