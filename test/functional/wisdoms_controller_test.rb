require 'test_helper'

class WisdomsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:wisdoms)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_wisdom
    assert_difference('Wisdom.count') do
      post :create, :wisdom => { }
    end

    assert_redirected_to wisdom_path(assigns(:wisdom))
  end

  def test_should_show_wisdom
    get :show, :id => wisdoms(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => wisdoms(:one).id
    assert_response :success
  end

  def test_should_update_wisdom
    put :update, :id => wisdoms(:one).id, :wisdom => { }
    assert_redirected_to wisdom_path(assigns(:wisdom))
  end

  def test_should_destroy_wisdom
    assert_difference('Wisdom.count', -1) do
      delete :destroy, :id => wisdoms(:one).id
    end

    assert_redirected_to wisdoms_path
  end
end
