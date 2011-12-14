require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  test "should send slimmer analytics headers" do
    get :show
    assert_equal "FCO",     @response.headers["X-Slimmer-Section"]
    assert_equal "133",     @response.headers["X-Slimmer-Need-ID"].to_s
    assert_equal "fco",     @response.headers["X-Slimmer-Format"]
    assert_equal "citizen", @response.headers["X-Slimmer-Proposition"]
  end
end
