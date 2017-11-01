class CreateTradeTags < ActiveRecord::Migration
  def change
    create_table :trade_tags, id: false do |t|
      t.column :id, "BIGINT PRIMARY KEY AUTO_INCREMENT"
      t.references :trading_history, index: true, foreign_key: true, limit: 8
      t.references :tag, index: true, foreign_key: true, limit: 8

      t.timestamps null: false
    end
  end
end
