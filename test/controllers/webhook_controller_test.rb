require 'test_helper'

class WebhookControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get webhook_create_url
    assert_response :success
  end

end
