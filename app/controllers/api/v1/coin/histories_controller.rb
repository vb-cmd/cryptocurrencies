class Api::V1::Coin::HistoriesController < ApplicationController
  before_action :set_coin

  def show
    date_start = params[:start]
    date_end = params[:end]

    @histories = if params_valid?(date_start, date_end)
                   @coin.histories.where('date BETWEEN ? AND ?', date_start, date_end)
                 else
                   @coin.histories
                 end
  end

  private

  REGEX_DATE = /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/

  def set_coin
    @coin = Coin.find_by(short_name: params[:coin_id])
  end

  def params_valid?(date_start, date_end)
    date_start && date_end &&
      date_start.match?(REGEX_DATE) && date_end.match?(REGEX_DATE)
  end
end
