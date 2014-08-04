require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  setup do
    @item = items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item" do
    assert_difference('Item.count') do
      post :create, item: { distributor: @item.distributor, item_model: @item.item_model, item_name: @item.item_name, item_serial: @item.item_serial, manufacturer: @item.manufacturer, order_id: @item.order_id, stock_id: @item.stock_id, stock_type: @item.stock_type }
    end

    assert_redirected_to item_path(assigns(:item))
  end

  test "should show item" do
    get :show, id: @item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item
    assert_response :success
  end

  test "should update item" do
    patch :update, id: @item, item: { distributor: @item.distributor, item_model: @item.item_model, item_name: @item.item_name, item_serial: @item.item_serial, manufacturer: @item.manufacturer, order_id: @item.order_id, stock_id: @item.stock_id, stock_type: @item.stock_type }
    assert_redirected_to item_path(assigns(:item))
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete :destroy, id: @item
    end

    assert_redirected_to items_path
  end
end
