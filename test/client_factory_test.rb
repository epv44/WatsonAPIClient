require 'test_helper'

class ClientFactoryTest < Minitest::Test
  def test_initial_message_for_string
    tts_client = WatsonTtsAsrClient::ClientFactory.new("text", MockWebsocketClient.new('tts'))
    assert_equal ({ text: "text", accept: "audio/wav "}.to_json ), tts_client.process

  end

  def test_initial_message_for_audio
    ascii_data = File.binread('sample/test_audio.wav')
    asr_client = WatsonTtsAsrClient::ClientFactory.new(ascii_data, MockWebsocketClient.new('asr'))
    assert_equal ({ action: "start", :"content-type"=>"audio/l16;rate=22050" }.to_json), asr_client.process
  end
end

class MockWebsocketClient
  def initialize(type)
    @type = type
  end

  def callout(text, data)
    text
  end
end
