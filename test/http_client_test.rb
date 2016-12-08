require 'test_helper'

class HttpClientTest < Minitest::Test
  def test_get_method
    stub_request(:get, "https://www.example.com")
    response = WatsonTtsAsrClient::HttpClient.get(URI("https://www.example.com"))
    assert_equal response.code, "200"
  end
end