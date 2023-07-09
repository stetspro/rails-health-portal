require "test_helper"

class Patients::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get patients_registrations_new_url
    assert_response :success
  end

  test "should get create" do
    get patients_registrations_create_url
    assert_response :success
  end
end
