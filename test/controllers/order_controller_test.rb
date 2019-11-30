require 'test_helper'

class OrderControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get order_new_url
    assert_response :success
  end

  test "should get destory" do
    get order_destory_url
    assert_response :success
  end

end
