class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags, id: false do |t|
      t.column :id, "BIGINT PRIMARY KEY AUTO_INCREMENT"
      t.string :name, null: false
      t.string :color, null: false
      t.text :info

      t.timestamps null: false
    end
  end
end
