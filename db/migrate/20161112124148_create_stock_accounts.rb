class CreateStockAccounts < ActiveRecord::Migration
  def change
    create_table :stock_accounts do |t|
      t.integer :user_id, null: false
      t.integer :stock_company_id, null: false
      t.integer :assets_sum, null: false, default: 0
      t.text :info

      t.timestamps null: false
    end
  end
end
