require 'test_helper'

class StockAuditsControllerTest < ActionController::TestCase
  setup do
    @stock_audit = stock_audits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stock_audits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stock_audit" do
    assert_difference('StockAudit.count') do
      post :create, stock_audit: { alternator: @stock_audit.alternator, comment: @stock_audit.comment, engine: @stock_audit.engine, stock: @stock_audit.stock, user: @stock_audit.user }
    end

    assert_redirected_to stock_audit_path(assigns(:stock_audit))
  end

  test "should show stock_audit" do
    get :show, id: @stock_audit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stock_audit
    assert_response :success
  end

  test "should update stock_audit" do
    patch :update, id: @stock_audit, stock_audit: { alternator: @stock_audit.alternator, comment: @stock_audit.comment, engine: @stock_audit.engine, stock: @stock_audit.stock, user: @stock_audit.user }
    assert_redirected_to stock_audit_path(assigns(:stock_audit))
  end

  test "should destroy stock_audit" do
    assert_difference('StockAudit.count', -1) do
      delete :destroy, id: @stock_audit
    end

    assert_redirected_to stock_audits_path
  end
end
