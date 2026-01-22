require "test_helper"

class Admin::WithdrawalsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_withdrawals_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_withdrawals_create_url
    assert_response :success
  end
end
