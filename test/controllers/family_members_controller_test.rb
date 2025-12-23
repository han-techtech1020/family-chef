require "test_helper"

class FamilyMembersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get family_members_index_url
    assert_response :success
  end

  test "should get new" do
    get family_members_new_url
    assert_response :success
  end

  test "should get create" do
    get family_members_create_url
    assert_response :success
  end

  test "should get edit" do
    get family_members_edit_url
    assert_response :success
  end

  test "should get update" do
    get family_members_update_url
    assert_response :success
  end

  test "should get destroy" do
    get family_members_destroy_url
    assert_response :success
  end
end
