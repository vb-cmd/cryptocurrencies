json.rank coin.rank
json.symbol coin.symbol
json.full_name coin.full_name
json.short_name coin.short_name
json.market_cap coin.market_cap
json.price coin.price
json.change_24h coin.change_24h
json.icon_url "https://assets.coincap.io/assets/icons/#{coin.symbol.downcase}@2x.png"
json.histories_url api_v1_coin_coin_histories_url(coin.short_name, format: :json)
