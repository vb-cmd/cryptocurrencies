require "test_helper"

class Api::V1::Coin::HistoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_coin_histories_index_url
    assert_response :success
  end
end
