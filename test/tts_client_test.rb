require 'test_helper'

class TtsClientTest < Minitest::Test
  def test_should_return_processed_string
    tts_client = WatsonTtsAsrClient::TtsClient.new("text", MockWebsocketClient.new('tts'))
    assert_equal "text", tts_client.process_text
  end
end

class MockWebsocketClient
  
  def initialize(type)
    @type = type
  end

  def callout(text)
    text
  end
end
