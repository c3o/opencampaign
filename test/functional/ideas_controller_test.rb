require 'test_helper'

class IdeasControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:ideas)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_idea
    assert_difference('Idea.count') do
      post :create, :idea => { }
    end

    assert_redirected_to idea_path(assigns(:idea))
  end

  def test_should_show_idea
    get :show, :id => ideas(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => ideas(:one).id
    assert_response :success
  end

  def test_should_update_idea
    put :update, :id => ideas(:one).id, :idea => { }
    assert_redirected_to idea_path(assigns(:idea))
  end

  def test_should_destroy_idea
    assert_difference('Idea.count', -1) do
      delete :destroy, :id => ideas(:one).id
    end

    assert_redirected_to ideas_path
  end
end
