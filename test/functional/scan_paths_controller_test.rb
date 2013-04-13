require 'test_helper'

class ScanPathsControllerTest < ActionController::TestCase
  setup do
    @scan_path = scan_paths(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scan_paths)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scan_path" do
    assert_difference('ScanPath.count') do
      post :create, scan_path: { active: @scan_path.active, interval: @scan_path.interval, last_visit: @scan_path.last_visit, path: @scan_path.path }
    end

    assert_redirected_to scan_path_path(assigns(:scan_path))
  end

  test "should show scan_path" do
    get :show, id: @scan_path
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @scan_path
    assert_response :success
  end

  test "should update scan_path" do
    put :update, id: @scan_path, scan_path: { active: @scan_path.active, interval: @scan_path.interval, last_visit: @scan_path.last_visit, path: @scan_path.path }
    assert_redirected_to scan_path_path(assigns(:scan_path))
  end

  test "should destroy scan_path" do
    assert_difference('ScanPath.count', -1) do
      delete :destroy, id: @scan_path
    end

    assert_redirected_to scan_paths_path
  end
end
