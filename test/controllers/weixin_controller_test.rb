require 'test_helper'

class WeixinControllerTest < ActionDispatch::IntegrationTest
  test "should get notify" do
    get weixin_notify_url
    assert_response :success
  end

end
