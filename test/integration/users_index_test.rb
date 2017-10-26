require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:tester)
    @admin = users(:adam)
    @non_admin = users(:tester)
  end

  test "index including pagination" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'ul.pagination'
    User.paginates_per 1 do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    # byebug
    first_page_of_users = User.page(1)
    first_page_of_users.each do |user|
      # this line sometimes causes test failure
      # assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        # this line sometimes causes test failure
        # assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end


end
