class Coin < ApplicationRecord
  # after_update :send_message_to_room

  validates :rank, presence: true
  validates :symbol, presence: true
  validates :full_name, presence: true
  validates :short_name, presence: true, uniqueness: true
  validates :market_cap, presence: true
  validates :price, presence: true
  validates :change_24h, presence: true

  has_many :histories, class_name: 'CoinHistory', dependent: :destroy

  max_paginates_per 50

  private

  def send_message_to_room
    PriceChangeChannel.broadcast_to(PriceChangeChannel::ALL,
                                    {
                                      short_name:,
                                      price:,
                                      change_24h:
                                    })
  end
end
