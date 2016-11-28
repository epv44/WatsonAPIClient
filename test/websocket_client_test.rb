require 'test_helper'

class WebsocketClientTest < Minitest::Test
  def test_default_options_are_set
    ws_client = WatsonTtsAsrClient::WebsocketClient.new('tts')
    assert_equal ws_client.options[:tts_url].to_s, 'wss://stream.watsonplatform.net/text-to-speech/api/v1/synthesize'
  end

  def test_default_options_merge
    ws_client = WatsonTtsAsrClient::WebsocketClient.new('tts', {asr_url: 'wss'})
    assert_equal ws_client.options[:asr_url].to_s, 'wss'
  end

  def test_default_options_config
    WatsonTtsAsrClient::WebsocketClient.default_options[:watson_token] = '1234'
    ws_client = WatsonTtsAsrClient::WebsocketClient.new('tts')
    assert_equal ws_client.options[:watson_token], '1234'
  end
end
