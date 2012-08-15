require 'test_helper'

module Publinator
  class HomeControllerTest < ActionController::TestCase
    test "should get index" do
      get :index
      assert_response :success
    end
  
    test "should get page" do
      get :page
      assert_response :success
    end
  
  end
end
