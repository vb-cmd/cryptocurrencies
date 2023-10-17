if Rails.const_defined?('Server')
  scheduler = Rufus::Scheduler.new

  # Update information about coins every 10 seconds
  scheduler.every '10s' do
    json_hash = CoincapService.cryptocurrencies

    Rails.logger.info "Update 100 coins from Coincap at #{Time.now}"

    json_hash.each do |coin_hash|
      coin = Coin.find_by(short_name: coin_hash['id'])

      if coin.nil?
        Coin.create_and_update_from_coincap(coin_hash)
        next
      end

      coin.update_numerics_from_coincap(coin_hash) if coin.any_numerics_outdated_from_coincap?(coin_hash)
    end
  rescue StandardError => e
    Rails.logger.error "#{e.message} at #{Time.now}"
  end

  # Delete histories and create new for each coin every day
  scheduler.every '1d' do
    Coin.all.each do |coin|
      Rails.logger.info "Update coin '#{coin.short_name}' histories from Coincap at #{Time.now}"
      json = CoincapService.cryptocurrency_histories(coin.short_name)

      Rails.logger.info "Delete all histories for #{coin.short_name} at #{Time.now}"
      coin.histories.destroy_all

      Rails.logger.info "Create new histories for #{coin.short_name} at #{Time.now}"
      json.each do |history|
        coin.histories.create(price: history['priceUsd'], date: history['date'])
      end
    end
  rescue StandardError => e
    Rails.logger.error "#{e.message} at #{Time.now}"
  end
end
