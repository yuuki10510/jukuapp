require "test_helper"

class Admin::ScoresControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_scores_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_scores_create_url
    assert_response :success
  end

  test "should get edit" do
    get admin_scores_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_scores_update_url
    assert_response :success
  end
end
