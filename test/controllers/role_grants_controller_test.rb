require 'test_helper'

class RoleGrantsControllerTest < ActionController::TestCase
  setup do
    @role_grant = role_grants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:role_grants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create role_grant" do
    assert_difference('RoleGrant.count') do
      post :create, role_grant: {  }
    end

    assert_redirected_to role_grant_path(assigns(:role_grant))
  end

  test "should show role_grant" do
    get :show, id: @role_grant
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @role_grant
    assert_response :success
  end

  test "should update role_grant" do
    patch :update, id: @role_grant, role_grant: {  }
    assert_redirected_to role_grant_path(assigns(:role_grant))
  end

  test "should destroy role_grant" do
    assert_difference('RoleGrant.count', -1) do
      delete :destroy, id: @role_grant
    end

    assert_redirected_to role_grants_path
  end
end
