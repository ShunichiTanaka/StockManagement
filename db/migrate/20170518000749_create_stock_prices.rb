class CreateStockPrices < ActiveRecord::Migration
  def change
    create_table :stock_prices, id: false do |t|
      t.column :id, "BIGINT PRIMARY KEY AUTO_INCREMENT"
      t.date :target_date, null: false
      t.integer :code, null: false
      t.integer :market_id, null: false
      t.integer :open, null: false
      t.integer :high, null: false
      t.integer :low, null: false
      t.integer :close, null: false
      t.integer :trading_value, null: false, limit: 8

      t.timestamps null: false
    end
  end
end
