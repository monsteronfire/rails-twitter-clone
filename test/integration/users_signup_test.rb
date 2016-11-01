require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name: "", email: "user@invalid", password: "foo", password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert_select 'form[action="/signup"]'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'ul'
    assert_select 'li', 'Name can\'t be blank'
    assert_select 'li', 'Email is invalid'
    assert_select 'li', 'Password confirmation doesn\'t match Password'
    assert_select 'li', 'Password is too short (minimum is 6 characters)'
  end

  test "empty signup form" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name: "", email: "", password: "", password_confirmation: "" } }
    end
    assert_template 'users/new'
    assert_select 'form[action="/signup"]'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'ul'
    assert_select 'li', 'Name can\'t be blank'
    assert_select 'li', 'Email can\'t be blank'
    assert_select 'li', 'Email is invalid'
    assert_select 'li', 'Password can\'t be blank'
    assert_select 'li', 'Password is too short (minimum is 6 characters)'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: "Example User", email: "user@example.com", password:
     "foobar", password_confirmation: "foobar" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
    assert_not flash.empty?
  end
end
