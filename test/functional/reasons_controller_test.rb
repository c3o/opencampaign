require 'test_helper'

class ReasonsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:reasons)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_reason
    assert_difference('Reason.count') do
      post :create, :reason => { }
    end

    assert_redirected_to reason_path(assigns(:reason))
  end

  def test_should_show_reason
    get :show, :id => reasons(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => reasons(:one).id
    assert_response :success
  end

  def test_should_update_reason
    put :update, :id => reasons(:one).id, :reason => { }
    assert_redirected_to reason_path(assigns(:reason))
  end

  def test_should_destroy_reason
    assert_difference('Reason.count', -1) do
      delete :destroy, :id => reasons(:one).id
    end

    assert_redirected_to reasons_path
  end
end
