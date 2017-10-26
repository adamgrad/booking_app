require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:adam)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              email: "email.invalid",
                                              password:              "pass",
                                              password_confirmation: "word" } }

    # assert_template 'users/edit'
  end

  test "successful edit with friendly forwarding" do
    log_in_as(@user)
    get edit_user_path @user

    # Fix this part. Getting success response instead of edit_user_url
    # assert_redirected_to edit_user_url @user
    assert_template "users/edit"
    name = "Test"
    email = "email@spam.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?

    @user.reload
    assert_redirected_to user_path @user
    assert_equal @user.name, name
  end
end
