require 'test_helper'

module Prosperity
  class MetricsControllerTest < ActionController::TestCase
    test "should get index" do
      get :index
      assert_response :success
    end

  end
end
