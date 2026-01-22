require "test_helper"

class Admin::StudentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_students_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_students_show_url
    assert_response :success
  end
end
