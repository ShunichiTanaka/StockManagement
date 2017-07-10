class AddBollingerColumnToStockPrice < ActiveRecord::Migration
  def up
    add_column :stock_prices, :twenty_average, :float, limit: 8, after: :previous_price_ratio
    add_column :stock_prices, :standard_deviation, :float, limit: 8, after: :twenty_average
  end

  def down
    remove_column :stock_prices, :twenty_average
    remove_column :stock_prices, :standard_deviation
  end
end
