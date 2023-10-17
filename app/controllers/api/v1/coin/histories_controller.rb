class Api::V1::Coin::HistoriesController < ApplicationController
  before_action :set_coin

  def index
    @histories = @coin.histories
  end

  private

  def set_coin
    @coin = Coin.find(params[:coin_id])
  end
end
