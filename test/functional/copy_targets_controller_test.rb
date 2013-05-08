require 'test_helper'

class CopyTargetsControllerTest < ActionController::TestCase
  setup do
    @copy_target = copy_targets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:copy_targets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create copy_target" do
    assert_difference('CopyTarget.count') do
      post :create, copy_target: { active: @copy_target.active, path: @copy_target.path, prio: @copy_target.prio }
    end

    assert_redirected_to copy_target_path(assigns(:copy_target))
  end

  test "should show copy_target" do
    get :show, id: @copy_target
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @copy_target
    assert_response :success
  end

  test "should update copy_target" do
    put :update, id: @copy_target, copy_target: { active: @copy_target.active, path: @copy_target.path, prio: @copy_target.prio }
    assert_redirected_to copy_target_path(assigns(:copy_target))
  end

  test "should destroy copy_target" do
    assert_difference('CopyTarget.count', -1) do
      delete :destroy, id: @copy_target
    end

    assert_redirected_to copy_targets_path
  end
end
