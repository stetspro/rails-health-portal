require "test_helper"

class Patients::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get patients_sessions_new_url
    assert_response :success
  end

  test "should get create" do
    get patients_sessions_create_url
    assert_response :success
  end

  test "should get destroy" do
    get patients_sessions_destroy_url
    assert_response :success
  end
end
