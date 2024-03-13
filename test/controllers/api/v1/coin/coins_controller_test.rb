require "test_helper"

class Api::V1::Coin::CoinsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_coin_coins_url, as: :json, params: { page: 1, per_page: 50 }
    assert_response :success
  end
end
