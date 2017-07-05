class AddColumnToStockPrice < ActiveRecord::Migration
  def up
    add_column :stock_prices, :previous_price, :integer, after: :trading_value
    add_column :stock_prices, :previous_price_ratio, :float, limit: 8, after: :previous_price
  end

  def down
    remove_column :stock_prices, :previous_price
    remove_column :stock_prices, :previous_price_ratio
  end
end
