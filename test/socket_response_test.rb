require 'test_helper'

class SocketResponseTest < Minitest::Test
  def test_set_properties
    socket_response = WatsonTtsAsrClient::Model::SocketResponse.new()
    socket_response.data = "data"
    socket_response.set_json({ data: "data", body: "body" }.to_json)
    assert_equal socket_response.data, "data"
    assert_equal socket_response.get_json.body, "body"
  end
end