module ScheduleSet
  module Coincap
    module_function

    # Update all coins
    def update_coins
      json_hash = CoincapService.cryptocurrencies

      Rails.logger.info "Update 100 coins from Coincap at #{Time.now}"

      json_hash.each { |coin_hash|  CoincapService.create_or_update_coin(coin_hash) }
    rescue StandardError => e
      Rails.logger.error "#{e.message} at #{Time.now}"
    end

    # Delete histories for each coin and create new
    def update_histories
      Coin.all.each do |coin_hash|
        Rails.logger.info "Update coin '#{coin_hash.short_name}' histories from Coincap at #{Time.now}"
        histories_hash = CoincapService.cryptocurrency_histories(coin_hash.short_name)

        Rails.logger.info "Delete all histories for #{coin_hash.short_name} at #{Time.now}"
        coin_hash.histories.destroy_all

        Rails.logger.info "Create new histories for #{coin_hash.short_name} at #{Time.now}"
        CoincapService.create_coin_histories(coin_hash, histories_hash)
      end
    rescue StandardError => e
      Rails.logger.error "#{e.message} at #{Time.now}"
    end
  end
end

if Rails.const_defined?('Server')
  scheduler = Rufus::Scheduler.new

  scheduler.every '1m' do
    ScheduleSet::Coincap.update_coins
  end

  scheduler.every '1d' do
    ScheduleSet::Coincap.update_histories
  end
end
