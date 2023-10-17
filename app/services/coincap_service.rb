module CoincapService
  class << self
    # @param [String] search (nil) Search by asset id (bitcoin) or symbol (BTC)
    # @param [String] ids (nil) Query with multiple ids=bitcoin,ethereum,monero
    # @param [Integer] limit (nil) Max limit of 2000
    # @param [Integer] offset (nil) Offset
    # @return [Array<Hash>]
    def cryptocurrencies(**options)
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
end
