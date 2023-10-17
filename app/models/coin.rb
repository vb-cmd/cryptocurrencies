class Coin < ApplicationRecord
  after_update :send_message_to_room

  validates :rank, presence: true
  validates :symbol, presence: true
  validates :full_name, presence: true
  validates :short_name, presence: true, uniqueness: true
  validates :supply, presence: true
  validates :market_cap, presence: true
  validates :volume_24h, presence: true
  validates :price, presence: true
  validates :change_24h, presence: true

  has_many :histories, class_name: 'CoinHistory', dependent: :destroy

  def self.create_and_update_from_coincap(coin)
    find_or_create_by(short_name: coin['id'])
      .update(symbol: coin['symbol'],
              rank: coin['rank'],
              short_name: coin['id'],
              full_name: coin['name'],
              supply: coin['supply'],
              market_cap: coin['marketCapUsd'],
              volume_24h: coin['volumeUsd24Hr'],
              price: coin['priceUsd'],
              change_24h: coin['changePercent24Hr'])
  end

  def update_numerics_from_coincap(coin_hash)
    update(market_cap: coin_hash['marketCapUsd'],
           volume_24h: coin_hash['volumeUsd24Hr'],
           price: coin_hash['priceUsd'],
           change_24h: coin_hash['changePercent24Hr'],
           supply: coin_hash['supply'])
  end

  def any_numerics_outdated_from_coincap?(coin_hash)
    (market_cap.to_s != coin_hash['marketCapUsd']) &&
      (volume_24h.to_s != coin_hash['volumeUsd24Hr']) &&
      (price.to_s != coin_hash['priceUsd']) &&
      (change_24h.to_s != coin_hash['changePercent24Hr']) &&
      (supply.to_s != coin_hash['supply'])
  end

  private

  def send_message_to_room
    PriceChangeChannel.broadcast_to(PriceChangeChannel::GLOBAL_NAME,
                                    {
                                      short_name:,
                                      market_cap:,
                                      volume_24h:,
                                      price:,
                                      change_24h:,
                                      supply:
                                    })
  end
end
