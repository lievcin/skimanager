require 'test_helper'

class BootSizesControllerTest < ActionController::TestCase
  setup do
    @boot_size = boot_sizes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:boot_sizes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create boot_size" do
    assert_difference('BootSize.count') do
      post :create, boot_size: { size: @boot_size.size }
    end

    assert_redirected_to boot_size_path(assigns(:boot_size))
  end

  test "should show boot_size" do
    get :show, id: @boot_size
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @boot_size
    assert_response :success
  end

  test "should update boot_size" do
    put :update, id: @boot_size, boot_size: { size: @boot_size.size }
    assert_redirected_to boot_size_path(assigns(:boot_size))
  end

  test "should destroy boot_size" do
    assert_difference('BootSize.count', -1) do
      delete :destroy, id: @boot_size
    end

    assert_redirected_to boot_sizes_path
  end
end
