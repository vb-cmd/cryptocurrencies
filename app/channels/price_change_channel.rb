class PriceChangeChannel < ApplicationCable::Channel
  GLOBAL_NAME = 'all'

  def subscribed
    stream_from "price_change:#{GLOBAL_NAME}"
  end

  def unsubscribed; end
end
