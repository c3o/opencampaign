require 'test_helper'

class LinksControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:links)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_link
    assert_difference('Link.count') do
      post :create, :link => { }
    end

    assert_redirected_to link_path(assigns(:link))
  end

  def test_should_show_link
    get :show, :id => links(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => links(:one).id
    assert_response :success
  end

  def test_should_update_link
    put :update, :id => links(:one).id, :link => { }
    assert_redirected_to link_path(assigns(:link))
  end

  def test_should_destroy_link
    assert_difference('Link.count', -1) do
      delete :destroy, :id => links(:one).id
    end

    assert_redirected_to links_path
  end
end
