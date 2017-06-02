# == Schema Information
#
# Table name: markets
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  info       :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Market < ActiveRecord::Base
end
