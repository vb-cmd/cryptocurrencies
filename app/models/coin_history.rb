class CoinHistory < ApplicationRecord
  belongs_to :coin
  validates :price, presence: true
  validates :date, presence: true
end
