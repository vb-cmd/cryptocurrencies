class Api::V1::Coin::CoinsController < ApplicationController
  def index
    @coins = Coin.all
  end
end
