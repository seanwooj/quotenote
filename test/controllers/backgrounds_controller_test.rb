require "test_helper"

class BackgroundsControllerTest < ActionController::TestCase

  def background
    @background ||= backgrounds :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:backgrounds)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Background.count') do
      post :create, background: {  }
    end

    assert_redirected_to background_path(assigns(:background))
  end

  def test_show
    get :show, id: background
    assert_response :success
  end

  def test_edit
    get :edit, id: background
    assert_response :success
  end

  def test_update
    put :update, id: background, background: {  }
    assert_redirected_to background_path(assigns(:background))
  end

  def test_destroy
    assert_difference('Background.count', -1) do
      delete :destroy, id: background
    end

    assert_redirected_to backgrounds_path
  end
end
