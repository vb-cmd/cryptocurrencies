[Coin, CoinHistory].each(&:delete_all)

coins = CoincapService.cryptocurrencies
coins.each do |coin_hash|
  CoincapService.create_or_update_coin(coin_hash)
  puts "Created a coin: #{coin_hash['id']}"
end

puts('-' * 100)

Coin.all.each_with_index do |coin, index|
  puts "#{index}. Fetch coin '#{coin.short_name}' histories from Coincap at #{Time.now}"
  histories_hash = CoincapService.cryptocurrency_histories(coin.short_name)

  puts "Begin to add histories for #{coin.short_name} at #{Time.now}"

  CoincapService.create_coin_histories(coin, histories_hash)

  puts "End to added histories for #{coin.short_name} at #{Time.now}"
end
