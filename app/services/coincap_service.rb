module CoincapService
  module_function

  def create_or_update_coin(coin_hash)
    Coin.find_or_create_by(short_name: coin_hash['id'])
        .update(symbol: coin_hash['symbol'],
                rank: coin_hash['rank'],
                short_name: coin_hash['id'],
                full_name: coin_hash['name'],
                market_cap: coin_hash['marketCapUsd'],
                price: coin_hash['priceUsd'],
                change_24h: coin_hash['changePercent24Hr'])
  end

  def create_coin_histories(coin_model, coin_histories_hash)
    coin_histories_hash.each do |coin_history_hash|
      coin_model.histories.create(price: coin_history_hash['priceUsd'], date: coin_history_hash['date'])
    end
  end

  # @param [String] search (nil) Search by asset id (bitcoin) or symbol (BTC)
  # @param [String] ids (nil) Query with multiple ids=bitcoin,ethereum,monero
  # @param [Integer] limit (nil) Max limit of 2000
  # @param [Integer] offset (nil) Offset
  # @return [Array<Hash>]
  def cryptocurrencies(**options)
    options[:limit] = options[:limit] || 1000
    options[:offset] = options[:offset] || 0

    json_str = Coincap::AssetsPrice.cryptocurrencies(**options)
    JSON.parse(json_str)['data']
  end

  # @param asset_id [String] Asset id, for example, bitcoin
  # @param interval [Symbol|String] Select one from the list of TIME_INTERVAL values
  #   for example, a string 'm1' or a symbol :one_minute
  # @return [Array<Hash>]
  def cryptocurrency_histories(coin_id, interval = :one_day)
    json_str = Coincap::AssetsPrice.cryptocurrency_history(coin_id, interval)
    JSON.parse(json_str)['data']
  end
end
