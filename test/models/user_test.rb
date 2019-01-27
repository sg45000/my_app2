require 'test_helper'

class UserTest < ActiveSupport::TestCase
   def setup
     @user = User.new(name: "sample", email: "sample@sample.com",
              password: "foobar", password_confirmation: "foobar")
   end
   
   test "should be valid" do
     assert @user.valid?
   end
   
   test "name wrong length should be invalid" do
     @user.name = "abc"
     assert_not @user.valid?
     
     @user.name = "a"*21
     assert_not @user.valid?
   end
   
   test "blank name should be invalid" do
     @user.name = "   "
     assert_not @user.valid?
   end
   
   test "blank email should be invalid" do
     @user.email = "   "
     assert_not @user.valid?
   end
   
   test "wrong mail address should be invalid" do
     @user.email = "abc@com"
     assert_not @user.valid?
   end
   
   test "wrong password should be invalid" do
     @user.password = "foo"
     @user.password_confirmation = "bar"
     assert_not @user.valid?
   end
   
   test "email uniqueness test" do
     @user.save
     assert_no_difference "User.count" do
       @user.save
     end
   end
   
end
