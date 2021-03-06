# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  color      :string(255)      not null
#  info       :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ActiveRecord::Base
  has_many :trading_histories, through: :trade_tags
  has_many :trade_tags

  validates :name, presence: true
  validates :color, presence: true
end
