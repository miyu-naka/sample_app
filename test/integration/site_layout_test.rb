require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest

test "layout links when not logged in" do
  get root_path
  assert_template 'static_pages/home'
  assert_select "a[href=?]", root_path, count: 2  # ロゴ + Home
  assert_select "a[href=?]", help_path
  assert_select "a[href=?]", login_path
  assert_select "a[href=?]", users_path, count: 0
end

test "layout links when logged in" do
  log_in_as(users(:michael))
  get root_path
  assert_template 'static_pages/home'
  assert_select "a[href=?]", root_path, count: 2
  assert_select "a[href=?]", help_path
  assert_select "a[href=?]", users_path
  assert_select "a[href=?]", edit_user_path(users(:michael))
  assert_select "a[href=?]", logout_path
end

end
