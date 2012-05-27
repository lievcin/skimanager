require 'test_helper'

class SkiSizesControllerTest < ActionController::TestCase
  setup do
    @ski_size = ski_sizes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ski_sizes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ski_size" do
    assert_difference('SkiSize.count') do
      post :create, ski_size: { size: @ski_size.size }
    end

    assert_redirected_to ski_size_path(assigns(:ski_size))
  end

  test "should show ski_size" do
    get :show, id: @ski_size
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ski_size
    assert_response :success
  end

  test "should update ski_size" do
    put :update, id: @ski_size, ski_size: { size: @ski_size.size }
    assert_redirected_to ski_size_path(assigns(:ski_size))
  end

  test "should destroy ski_size" do
    assert_difference('SkiSize.count', -1) do
      delete :destroy, id: @ski_size
    end

    assert_redirected_to ski_sizes_path
  end
end
