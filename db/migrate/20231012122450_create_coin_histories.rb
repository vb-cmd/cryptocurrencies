class CreateCoinHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :coin_histories do |t|
      t.references :coin, unique: true
      t.decimal :price
      t.datetime :date
      
    end
  end
end