require "test_helper"

class CartsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get carts_show_url
    assert_response :success
  end

  test "should get add_product" do
    get carts_add_product_url
    assert_response :success
  end

  test "should get remove_product" do
    get carts_remove_product_url
    assert_response :success
  end

  test "should get checkout" do
    get carts_checkout_url
    assert_response :success
  end
end
