require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
   test "login failed" do
     get signin_path
     assert_template "sessions/new"
     post signin_path, params:{session: {email: "",
                                  password: "" }}
     assert_template "sessions/new"
     assert_not flash.empty?
     get root_path
     assert flash.empty?
   end
end
