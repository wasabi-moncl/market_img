require 'test_helper'

class BannersControllerTest < ActionController::TestCase
  setup do
    @banner = banners(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:banners)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create banner" do
    assert_difference('Banner.count') do
      post :create, banner: { bg_color: @banner.bg_color, content: @banner.content, font_color: @banner.font_color, font_size: @banner.font_size, photo_id: @banner.photo_id, pos_x: @banner.pos_x, pos_y: @banner.pos_y }
    end

    assert_redirected_to banner_path(assigns(:banner))
  end

  test "should show banner" do
    get :show, id: @banner
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @banner
    assert_response :success
  end

  test "should update banner" do
    put :update, id: @banner, banner: { bg_color: @banner.bg_color, content: @banner.content, font_color: @banner.font_color, font_size: @banner.font_size, photo_id: @banner.photo_id, pos_x: @banner.pos_x, pos_y: @banner.pos_y }
    assert_redirected_to banner_path(assigns(:banner))
  end

  test "should destroy banner" do
    assert_difference('Banner.count', -1) do
      delete :destroy, id: @banner
    end

    assert_redirected_to banners_path
  end
end
