class PriceChangeChannel < ApplicationCable::Channel
  ALL = 'all'

  def subscribed
    stream_from "price_change:#{ALL}"
  end

  def unsubscribed; end
end
