require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should login" do
    bo = users(:one)
    post :create, name: bo.name, password: 'password'
    assert_redirected_to admin_url
    assert_equal bo.id, session[:user_id]
  end

  test "should logout" do
    delete :destroy
    assert_redirected_to store_url
  end

  test "should fail login" do
    bo = users(:one)
    post :create, name: bo.name, password: 'wrong'
    assert_redirected_to login_url
  end 

end
