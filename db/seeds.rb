[User, Coin, CoinHistory].each(&:delete_all)

if Rails.env.development?
  puts 'Create user admin'
  User.create(email: 'admin@admin.com', password: 'password')
end

CoincapService.cryptocurrencies.each do |coin|
  Coin.create_and_update_from_coincap(coin)
  puts "Created coin: #{coin['id']}"
end

puts('-' * 100)

Coin.all.each do |coin|
  puts "Fetch coin '#{coin.short_name}' histories from Coincap at #{Time.now}"
  json = CoincapService.cryptocurrency_histories(coin.short_name)

  puts "Begin to add histories for #{coin.short_name} at #{Time.now}"
  json.each do |history|
    coin.histories.create(price: history['priceUsd'], date: history['date'])
  end
  puts "End to add histories for #{coin.short_name} at #{Time.now}"
end
