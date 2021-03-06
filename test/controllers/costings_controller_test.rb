require 'test_helper'

class CostingsControllerTest < ActionController::TestCase
  setup do
    @costing = costings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:costings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create costing" do
    assert_difference('Costing.count') do
      post :create, costing: { exchange_rate: @costing.exchange_rate, foreign_cost: @costing.foreign_cost, landed_cost: @costing.landed_cost, markup: @costing.markup, stock_id: @costing.stock_id }
    end

    assert_redirected_to costing_path(assigns(:costing))
  end

  test "should show costing" do
    get :show, id: @costing
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @costing
    assert_response :success
  end

  test "should update costing" do
    patch :update, id: @costing, costing: { exchange_rate: @costing.exchange_rate, foreign_cost: @costing.foreign_cost, landed_cost: @costing.landed_cost, markup: @costing.markup, stock_id: @costing.stock_id }
    assert_redirected_to costing_path(assigns(:costing))
  end

  test "should destroy costing" do
    assert_difference('Costing.count', -1) do
      delete :destroy, id: @costing
    end

    assert_redirected_to costings_path
  end
end
