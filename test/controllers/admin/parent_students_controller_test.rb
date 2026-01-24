require "test_helper"

class Admin::ParentStudentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_parent_students_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_parent_students_create_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_parent_students_destroy_url
    assert_response :success
  end
end
