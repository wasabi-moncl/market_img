require 'test_helper'

class MoldsControllerTest < ActionController::TestCase
  setup do
    @mold = molds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:molds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mold" do
    assert_difference('Mold.count') do
      post :create, mold: { name: @mold.name, part: @mold.part, template_id: @mold.template_id }
    end

    assert_redirected_to mold_path(assigns(:mold))
  end

  test "should show mold" do
    get :show, id: @mold
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mold
    assert_response :success
  end

  test "should update mold" do
    put :update, id: @mold, mold: { name: @mold.name, part: @mold.part, template_id: @mold.template_id }
    assert_redirected_to mold_path(assigns(:mold))
  end

  test "should destroy mold" do
    assert_difference('Mold.count', -1) do
      delete :destroy, id: @mold
    end

    assert_redirected_to molds_path
  end
end
