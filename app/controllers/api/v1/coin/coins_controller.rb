class Api::V1::Coin::CoinsController < ApplicationController
  def index
    page, per_page = set_params

    @coins = Coin.page(page).per(per_page)
  end

  private

  def set_params
    [params[:page] || 1, params[:per_page] || 50]
  end
end
