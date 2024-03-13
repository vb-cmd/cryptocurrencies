class CreateCoins < ActiveRecord::Migration[7.0]
  def change
    create_table :coins do |t|
      t.integer :rank
      t.string :symbol
      t.string :short_name, null: false, unique: true
      t.string :full_name
      t.decimal :market_cap
      t.decimal :price
      t.decimal :change_24h

      t.timestamps
    end
  end
end
