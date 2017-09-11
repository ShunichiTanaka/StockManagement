module Admin::TradingHistoriesHelper
  def select_tags
    Tag.all.pluck(:name, :id)
  end
end
