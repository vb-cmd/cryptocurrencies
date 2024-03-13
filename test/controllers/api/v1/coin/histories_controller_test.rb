require 'test_helper'

class Api::V1::Coin::HistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @coin = coins(:bitcoin)
  end

  test 'should get index' do
    get api_v1_coin_coin_histories_url(@coin), as: :json,
                                               params: {
                                                 start: DateTime.now.prev_month.strftime('%Y-%m-%d'),
                                                 end: DateTime.now.strftime('%Y-%m-%d')
                                               }
    assert_response :success
  end
end
