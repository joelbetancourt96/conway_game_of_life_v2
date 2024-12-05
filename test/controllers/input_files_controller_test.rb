require "test_helper"

class InputFilesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get input_files_new_url
    assert_response :success
  end

  test "should get create" do
    get input_files_create_url
    assert_response :success
  end
end
