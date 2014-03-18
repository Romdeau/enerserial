require 'test_helper'

class AlternatorsControllerTest < ActionController::TestCase
  setup do
    @alternator = alternators(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:alternators)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create alternator" do
    assert_difference('Alternator.count') do
      post :create, alternator: { alternator: @alternator.alternator, serial: @alternator.serial, type: @alternator.type }
    end

    assert_redirected_to alternator_path(assigns(:alternator))
  end

  test "should show alternator" do
    get :show, id: @alternator
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @alternator
    assert_response :success
  end

  test "should update alternator" do
    patch :update, id: @alternator, alternator: { alternator: @alternator.alternator, serial: @alternator.serial, type: @alternator.type }
    assert_redirected_to alternator_path(assigns(:alternator))
  end

  test "should destroy alternator" do
    assert_difference('Alternator.count', -1) do
      delete :destroy, id: @alternator
    end

    assert_redirected_to alternators_path
  end
end
