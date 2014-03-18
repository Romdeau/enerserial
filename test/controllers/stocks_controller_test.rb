require 'test_helper'

class StocksControllerTest < ActionController::TestCase
  setup do
    @stock = stocks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stocks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stock" do
    assert_difference('Stock.count') do
      post :create, stock: { alternator_id: @stock.alternator_id, detail: @stock.detail, engine_id: @stock.engine_id, gesan_number: @stock.gesan_number, job_id: @stock.job_id, ppsr: @stock.ppsr, serial_number: @stock.serial_number, status: @stock.status, status_detail: @stock.status_detail }
    end

    assert_redirected_to stock_path(assigns(:stock))
  end

  test "should show stock" do
    get :show, id: @stock
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stock
    assert_response :success
  end

  test "should update stock" do
    patch :update, id: @stock, stock: { alternator_id: @stock.alternator_id, detail: @stock.detail, engine_id: @stock.engine_id, gesan_number: @stock.gesan_number, job_id: @stock.job_id, ppsr: @stock.ppsr, serial_number: @stock.serial_number, status: @stock.status, status_detail: @stock.status_detail }
    assert_redirected_to stock_path(assigns(:stock))
  end

  test "should destroy stock" do
    assert_difference('Stock.count', -1) do
      delete :destroy, id: @stock
    end

    assert_redirected_to stocks_path
  end
end
