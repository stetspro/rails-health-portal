require "test_helper"

class Doctors::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get doctors_registrations_new_url
    assert_response :success
  end

  test "should get create" do
    get doctors_registrations_create_url
    assert_response :success
  end
end
