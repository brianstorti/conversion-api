require 'minitest/autorun'
require 'rack/test'

require_relative '../lib/api'

class ApiTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Api
  end

  def test_returns_success
    get '/'
    assert last_response.ok?
    assert_equal "so modular", last_response.body
  end
end
